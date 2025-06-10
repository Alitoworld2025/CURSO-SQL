USE equipamientomedico;

-- VISTAS -- VISTAS-- VISTAS-- VISTAS-- VISTAS-- VISTAS-- VISTAS-- VISTAS-- VISTAS-- VISTAS-- VISTAS


-- VISTA CANTIDAD DE EQUIPOS POR NOMBRE MÁS RESULTADO DE CRITERIO DE INCLUSIÓN A PLAN DE MANTENIMIENTO FRECUENTE--
-- Esta vista tinene la finalidad de conocer la cantidad de equipos por tipo o nombre que se tiene.
-- Además, se conoce número de gestión de equipamiento, valor mediante el cual se define si se realizan preventivos frecuentes en
-- dichos equipos o solo se revisan cuando fallan, es decir se hacen solo mantenimientos correctivos.

CREATE VIEW Equipo_por_Tipo AS
SELECT
criterio_plan_mantenimiento.Equipo,
criterio_plan_mantenimiento.Id_Criterio_Plan_Mantenimiento,
COUNT(inventario.Id_Inventario) AS Cantidad,
criterio_plan_mantenimiento.NGE,
IF(criterio_plan_mantenimiento.NGE>11, "INCLUIDO EN PLAN DE MANTENIMIENTO", "NO INCLUIDO EN PLAN DE MANTENIMIENTO") as Resultado_Criterio
FROM criterio_plan_mantenimiento
INNER JOIN inventario ON inventario.Id_Criterio_Plan_Mantenimiento = criterio_plan_mantenimiento.Id_Criterio_Plan_Mantenimiento
GROUP BY criterio_plan_mantenimiento.Id_Criterio_Plan_Mantenimiento;

-- Prueba de la Vista --
SELECT*FROM Equipo_por_Tipo;


-- VISTA CANTIDAD DE CORRECTIVOS POR EQUIPO --
-- Esta vista tienen la finalidad de mostrar la cantidad de correctivos que tuvo cada equipo médico -- 
-- Para crear esta vista se relacionaron las tablas inventario y correctivos --
CREATE VIEW Cantidad_de_Correctivos_por_Equipo AS
SELECT
inventario.Nombre_Equipo,
correctivos.Id_Inventario,
COUNT(correctivos.Id_Correctivo) AS Cantidad_de_Correctivos
FROM correctivos
INNER JOIN inventario ON inventario.Id_Inventario = correctivos.Id_Inventario
GROUP BY Id_Inventario
ORDER BY Cantidad_de_Correctivos DESC;

-- Prueba de Vista --
SELECT*FROM Cantidad_de_Correctivos_por_Equipo;

-- VISTA DETALLADA DE PREVENTIVOS --
-- Esta vista tienen la finalidad de mostrar el detalle de equipo junto con la fecha de su último preventivo y las observaciones que se hicieron --
-- Para la creación de esta vista se relacionaron las tablas inventario, marca y preventivos --
CREATE VIEW Detalle_Preventivo AS
SELECT
inventario.Id_Inventario,
inventario.Nombre_Equipo,
marca.Nombre_Marca,
preventivos.Fecha_Preventivo AS Último_Preventivo,
inventario.Frecuencia_Mantenimiento_Preventivo_meses AS Frecuencia_Preventivo,
DATE_ADD(preventivos.Fecha_Preventivo, INTERVAL inventario.Frecuencia_Mantenimiento_Preventivo_meses MONTH) AS Próximo_Preventivo,
preventivos.Observaciones
FROM inventario
INNER JOIN preventivos ON inventario.Id_Inventario = preventivos.Id_Inventario
INNER JOIN marca ON inventario.Id_Marca = marca.Id_Marca;

-- Prueba de la Vista --
SELECT*FROM Detalle_Preventivo;

-- A la vista anterior, le podemos agregar el vencimiento de los mantenimientos preventivos.
-- Para ello, se crea la siguiente vista modificada

CREATE VIEW Preventivo_Detallado_Con_Vencimiento AS
SELECT
inventario.Id_Inventario,
inventario.Nombre_Equipo,
marca.Nombre_Marca,
preventivos.Fecha_Preventivo AS Último_Preventivo,
inventario.Frecuencia_Mantenimiento_Preventivo_meses AS Frecuencia_Preventivo,
DATE_ADD(preventivos.Fecha_Preventivo, INTERVAL inventario.Frecuencia_Mantenimiento_Preventivo_meses MONTH) AS Próximo_Preventivo,

IF (DATE_ADD(preventivos.Fecha_Preventivo, INTERVAL inventario.Frecuencia_Mantenimiento_Preventivo_meses MONTH) < CURDATE(), 
	CONCAT("El preventivo lleva un atraso de ", DATEDIFF(CURDATE(), DATE_ADD(preventivos.Fecha_Preventivo, INTERVAL inventario.Frecuencia_Mantenimiento_Preventivo_meses MONTH)),
            " días"),
    "Preventivo al día") AS Estado_General_Preventivo,
preventivos.Observaciones
FROM inventario
INNER JOIN preventivos ON inventario.Id_Inventario = preventivos.Id_Inventario
INNER JOIN marca ON inventario.Id_Marca = marca.Id_Marca;


-- Prueba de la Vista --
SELECT*FROM Preventivo_Detallado_Con_Vencimiento;


-- VISTA CANTIDAD DE FALLAS SEGUN TIPO DE FALLA --
-- Esta vista tiene la finalidad de mostrar cual es el mayor tipo de falla que más predomina --
-- A partir de esto, se podrán tomar acciones para mitigarlas --

CREATE VIEW Cantidad_Fallas_por_Tipo AS
SELECT
fallas.Tipo_Falla,
COUNT(correctivos.Id_Correctivo) AS Cantidad_de_Correctivos
FROM correctivos
INNER JOIN fallas ON correctivos.Id_Tipo_Falla = fallas.Id_Tipo_Falla
GROUP BY fallas.Tipo_Falla
ORDER BY Cantidad_de_Correctivos DESC;

-- Prueba de la Vista --
SELECT*FROM Cantidad_Fallas_por_Tipo;


-- PROCEDIMIENTOS -- PROCEDIMIENTOS -- PROCEDIMIENTOS -- PROCEDIMIENTOS -- PROCEDIMIENTOS -- PROCEDIMIENTOS -- PROCEDIMIENTOS

-- PROCEDIMIENTO PARA VER EL DETALLE DE CORRECTIVO POR ID_INVENTARIO --
-- Este procedimiento tiene la finalidad de ver el detalle histórico de las fallas en un equipamiento médico y como se solucionaron
-- El procedimiento relaciona las tablas inventario y correctivos --
DELIMITER //

CREATE PROCEDURE Ver_Historial_Correctivo_Equipo (
    IN p_Id_Inventario VARCHAR(100)
)
BEGIN
    SELECT 
		inventario.Id_Inventario,
		inventario.Nombre_Equipo,
        correctivos.Id_Correctivo,
        correctivos.Fecha_Inicio_Correctivo,
        correctivos.Fecha_Fin_Correctivo,
        correctivos.Estado_Correctivo,
        correctivos.Descripcion_Falla,
        correctivos.Resolucion_Falla
FROM correctivos
INNER JOIN inventario ON inventario.Id_Inventario = correctivos.Id_Inventario
WHERE inventario.Id_Inventario = p_Id_Inventario;
END //

DELIMITER ;

-- Prueba del Procedimiento --
CALL Ver_Historial_Correctivo_Equipo("CSI-47769-10");


-- PROCEDIMIENTO ALTA EQUIPOS --
-- Este procedimiento fue creado para simplificar el ingreso de un nuevo equipo al inventario. No necesitaremos escribir las sentencias INSERT INTO y VALUES --
DELIMITER //

CREATE PROCEDURE Alta_Equipos(
IN p_ID_Inventario VARCHAR(100),
IN p_Nombre_Equipo VARCHAR(100),
IN p_Id_Marca INT,
IN p_Modelo VARCHAR(100),
IN p_Serie VARCHAR(100),
IN p_Descripcion MEDIUMTEXT,
IN p_Id_Servicio INT,
IN p_Id_Proveedor INT,
IN p_Id_Categoria INT,
IN p_Fecha_Instalacion DATE,
IN p_Frecuencia_Mantenimiento_Preventivo_meses INT,
IN p_Costo FLOAT,
IN p_Orden_de_Compra INT,
IN p_Estado_Contractual VARCHAR(100),
IN p_Id_Criterio_Plan_Mantenimiento INT,
IN p_Estado_General VARCHAR(50)
)
BEGIN
	INSERT INTO 
    Inventario (Id_Inventario, Nombre_Equipo, Id_Marca, Modelo, Serie, Descripcion, 
				Id_Servicio, Id_Proveedor, Id_Categoria, Fecha_Instalacion, Frecuencia_Mantenimiento_Preventivo_meses, 
                Costo, Orden_de_Compra, Estado_Contractual, Id_Criterio_Plan_Mantenimiento, Estado_General)
    VALUES (p_Id_Inventario, p_Nombre_Equipo, p_Id_Marca, p_Modelo, p_Serie, p_Descripcion, 
			p_Id_Servicio, p_Id_Proveedor, p_Id_Categoria, p_Fecha_Instalacion, p_Frecuencia_Mantenimiento_Preventivo_meses,
            p_Costo, p_Orden_de_Compra, p_Estado_Contractual, p_Id_Criterio_Plan_Mantenimiento, p_Estado_General);

END //

DELIMITER ;

-- Prueba de Procedimiento --
CALL Alta_Equipos("CSI-38671-30", "Autoclave", 33, "VAP 5001", 210450, "Autoclave de Vapor de Agua", 6, 18, 4, "2021-09-06", 1, 47000, 49111, "Propio", 38671, "Operativo");
-- Luego eliminamos el registro --
DELETE FROM inventario WHERE Id_Inventario = "CSI-38671-30";


-- PROCEDIMIENTO AGREGAR PROVEEDOR -- 
-- Este procedimiento tiene la finalidad de simplificar la carga de un nuevo proveedor --
DELIMITER //

CREATE PROCEDURE Nuevo_Proveedor(
IN p_Nombre_Proveedor VARCHAR(100)
)

BEGIN
	INSERT INTO proveedor(Nombre_Proveedor)
    VALUES (p_Nombre_Proveedor);

END //

DELIMITER ;
-- Prueba de Procedimeinto --
CALL Nuevo_Proveedor("Reparaciones_Masini");

-- PROCEDIMIENTO PARA INGRESAR MARCAS --
-- Este procedimiento tiene la finalidad de simplificar el ingreso de una nueva marca --

DELIMITER //

CREATE PROCEDURE Nueva_Marca (
IN p_Nombre_Marca VARCHAR(100)
)

BEGIN
	INSERT INTO 
    marca(Nombre_Marca)
    VALUES (p_Nombre_Marca);

END //

DELIMITER ;

-- Prueba del Procedimiento -- 
CALL Nueva_Marca("Covidien");



-- PROCEDIMIENTO PARA VER EL ULTIMO PREVENTIVO --
-- Este procedimiento tiene la finalidad de ver cuando fue el último mantenimiento preventivo que tuvo un equipo --
-- El procedimeinto relaciona las tablas inventario y preventivos --
DELIMITER //

DELIMITER //

CREATE PROCEDURE Ver_Ultimo_Preventivo(
    IN p_Id_Inventario VARCHAR(100)
)
BEGIN
    SELECT 
		inventario.Id_Inventario,
		inventario.Nombre_Equipo,
        marca.Nombre_Marca,
        preventivos.Fecha_Preventivo AS Último_Preventivo,
        DATE_ADD(preventivos.Fecha_Preventivo, INTERVAL inventario.Frecuencia_Mantenimiento_Preventivo_meses MONTH) AS Próximo_Preventivo,
        preventivos.Observaciones
        
FROM preventivos
INNER JOIN inventario ON inventario.Id_Inventario = preventivos.Id_Inventario
INNER JOIN marca ON inventario.Id_Marca = marca.Id_Marca
WHERE inventario.Id_Inventario = p_Id_Inventario;
END //

DELIMITER ;
        

-- Prueba del Procedimiento --
CALL Ver_Ultimo_Preventivo("CSI-37806-6");


-- PROCEDIMIENTO INGRESO CORRECTIVO --
-- Este procedimiento tienen la finalidad de simplificar la carga del inicio de una mantenimiento correctivo.
-- En ocasiones el correctivo se inicia pero no se termina en el mismo día
-- Este procedimiento relaciona las tablas inventario y correctivos
DELIMITER //

CREATE PROCEDURE Inicio_Correctivo(
IN p_Id_Inventario VARCHAR(100),
IN p_Fecha_Inicio_Correctivo DATETIME,
IN p_Id_Tipo_Falla INT,
IN p_Descripcion_Falla MEDIUMTEXT
)

BEGIN
	INSERT INTO correctivos(Id_Inventario, Fecha_Inicio_Correctivo, Id_Tipo_Falla, Descripcion_Falla)
    VALUES (p_Id_Inventario, p_Fecha_Inicio_Correctivo, p_Id_Tipo_Falla, p_Descripcion_Falla);

END //

DELIMITER ;

-- Prueba de Procedimiento --
CALL Inicio_Correctivo("CSI-16231-10", NOW(), 1, "No se reconoce el WAM");


-- CERRAR CORRECTIVO --
-- En ocasiones, la reparación de un equipo no se termina en un solo día, por lo que es necesario tener un procedimiento que
-- facilite el cierre del mantenimiento.

DELIMITER //

CREATE PROCEDURE Cerrar_Correctivo(
IN p_Id_Correctivo INT,
IN p_Fecha_Fin_Correctivo DATETIME,
IN p_Estado_Correctivo VARCHAR(100),
IN p_Resolucion_Falla MEDIUMTEXT
)
BEGIN
		DECLARE v_Estado_Correctivo VARCHAR(100);
	    IF EXISTS (SELECT 1 FROM correctivos WHERE Id_Correctivo = p_Id_Correctivo) THEN
				UPDATE correctivos SET Fecha_Fin_Correctivo = p_Fecha_Fin_Correctivo WHERE Id_Correctivo = p_Id_Correctivo;
                UPDATE correctivos SET Estado_Correctivo = p_Estado_Correctivo WHERE Id_Correctivo = p_Id_Correctivo;
                UPDATE correctivos SET Resolucion_Falla = p_Resolucion_Falla WHERE Id_Correctivo = p_Id_Correctivo;
		ELSE SELECT "ID INCORRECTO" AS mensaje;
		END IF;
      
END //

DELIMITER ;

CALL Cerrar_Correctivo (178, NOW(), "Finalizado", "Se reemplazó placa principal del WAM");



-- TRIGGER -- TRIGGER -- TRIGGER -- TRIGGER -- TRIGGER -- TRIGGER -- TRIGGER -- TRIGGER -- TRIGGER

-- TRIGGER ID INVENTARIO --
-- Este trigger se activa cuando el ID del inventario no contiene la cantidad de caracteres mínimos.alter
-- Es muy posible que en la inserción de datos, el usuario olvide un número, por eso sale la advertencia,
-- a los fines de que se revise lo que se ingresa como ID.alter
-- Un punto de mejora, seria establecer una longitud máxima para el ID, puesto que no es muy probable que
-- el ID de inventario tenga más de 13 caracteres.

DELIMITER //
CREATE TRIGGER Chequeo_ID_Inventario
AFTER INSERT ON inventario
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.Id_Inventario) < 11 THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'FORMATO DE ID INCORRECTO';
   END IF;
END;
//
DELIMITER ;
