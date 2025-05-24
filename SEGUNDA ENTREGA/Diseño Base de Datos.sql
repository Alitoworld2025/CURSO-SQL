-- SE REALIZARON CAMBIOS RESPECTO A LA BASE DE DATOS PRESENTADA EN LA PRIMERA ENTREGA --
-- SE CREÓ UNA TABLA DE CRITERIO DE MANTENIMIENTO, A LOS FINES DE NO TENER INFORMACIÓN REDUNDANTE EN LA TABLA DE INVENTARIO --

CREATE DATABASE IF NOT EXISTS EquipamientoMedico;
USE EquipamientoMedico;

CREATE TABLE Servicios (
Id_Servicio INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Nombre_Servicio VARCHAR(100),
Telefono_Interno INT
);

CREATE TABLE Marca (
Id_Marca INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Nombre_Marca VARCHAR(100) NOT NULL
);

CREATE TABLE Proveedor (
Id_Proveedor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Nombre_Proveedor VARCHAR(100)
);

CREATE TABLE Categoria (
Id_Categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Nombre_Categoria VARCHAR(100)
);

-- NUEVA TABLA--

CREATE TABLE Criterio_Plan_Mantenimiento (
Id_Criterio_Plan_Mantenimiento INT PRIMARY KEY NOT NULL,
Equipo VARCHAR(100),
Valor_Funcion_Clinica INT,
Valor_Riesgo_Asociado INT,
Valor_Requerimiento_Mantenimiento INT,
Antecedentes INT,
NGE INT GENERATED ALWAYS AS (Valor_Funcion_Clinica + Valor_Riesgo_Asociado + Valor_Requerimiento_Mantenimiento + Antecedentes)
);

CREATE TABLE Inventario (
Id_Inventario VARCHAR(100) PRIMARY KEY NOT NULL,
Nombre_Equipo VARCHAR(100) NOT NULL,
Id_Marca INT,
FOREIGN KEY (Id_Marca) REFERENCES Marca(Id_Marca),
Modelo VARCHAR(100),
Serie VARCHAR(100) NOT NULL,
Descripcion MEDIUMTEXT,
Id_Servicio INT,
FOREIGN KEY (Id_Servicio) REFERENCES Servicios(Id_Servicio),
Id_Proveedor INT,
FOREIGN KEY (Id_Proveedor) REFERENCES Proveedor(Id_Proveedor),
Id_Categoria INT,
FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria),
Fecha_Instalacion DATE,
Frecuencia_Mantenimiento_Preventivo_meses INT,
Costo FLOAT,
Orden_de_Compra INT,
Estado_Contractual VARCHAR(100),
Id_Criterio_Plan_Mantenimiento INT,
FOREIGN KEY (Id_Criterio_Plan_Mantenimiento) REFERENCES Criterio_Plan_Mantenimiento(Id_Criterio_Plan_Mantenimiento),
Estado_General VARCHAR(50) DEFAULT "Operativo"
);

CREATE TABLE Fallas (
Id_Tipo_Falla INT PRIMARY KEY AUTO_INCREMENT,
Tipo_Falla VARCHAR(200),
Descripcion MEDIUMTEXT
);

CREATE TABLE Correctivos (
Id_Correctivo INT PRIMARY KEY AUTO_INCREMENT,
Id_Inventario VARCHAR(100),
FOREIGN KEY (Id_Inventario) REFERENCES Inventario(Id_Inventario),
Fecha_Inicio_Correctivo DATETIME,
Fecha_Fin_Correctivo DATETIME,
Id_Tipo_Falla INT,
Estado_Correctivo VARCHAR(100) DEFAULT "EN_CURSO",
FOREIGN KEY (Id_Tipo_Falla) REFERENCES Fallas(Id_Tipo_Falla),
Descripcion_Falla MEDIUMTEXT,
Resolucion_Falla MEDIUMTEXT
);

CREATE TABLE Preventivos (
Id_Preventivo INT PRIMARY KEY AUTO_INCREMENT,
Id_Inventario VARCHAR(100),
FOREIGN KEY (Id_Inventario) REFERENCES Inventario(Id_Inventario),
Fecha_Preventivo DATETIME,
Observaciones MEDIUMTEXT
);

INSERT INTO Servicios (Nombre_Servicio, Telefono_Interno) VALUES
("Internación", 55001),
("Guardia", 55002),
("Imágenes", 55003),
("UTI", 55004),
("Quirófano", 55005),
("Esterilización", 55006),
("Consultorios_Externos", 55007),
("Hospital_de_Día", 55008),
("Medicina_Nuclear", 55009),
("Farmacia", 55010),
("Hemodinamia", 55011),
("Laboratorio", 55012),
("Depósito", 55013);

INSERT INTO Marca (Nombre_Marca) VALUES
("Mindray"), 
("Drager"), 
("General_Electric"), 
("Philips"), 
("Welch_Allyn"), 
("Stryker"), 
("Storz"), 
("Schiller"), 
("Mortara"), 
("Pardo"), 
("Hillroom"), 
("Eccosur"), 
("Dyne"), 
("Berchtold"), 
("Maquet"), 
("Medtronic"), 
("Bbraun"), 
("Icu_Medical"), 
("Daesung_Maref"),
("Edwards"),
("Fresenius"),
("Newton"),
("Ecleris"),
("Nihon_Kohden"),
("Carestream"),
("Silfab"),
("CAM"),
("Roche"),
("Systel"),
("Bistos"),
("CEC"),
("Pentax"),
("Hogner"),
("Canon");

INSERT INTO Proveedor (Nombre_Proveedor) VALUES
("Tecnoimagen"),
("Agimed"),
("Drager"),
("Philips"),
("INTEC"),
("Eccosur"),
("General_Electric"),
("CSH"),
("Philips"),
("Euroswiss"),
("Conmil"),
("Electromedik"),
("Icu_Medical"),
("Fresenius"),
("Suizo_Argentina"),
("Bbraun"),
("Griensu"),
("Hogner"),
("Stryker"),
("Canon"),
("ITS"),
("Medtronic");

INSERT INTO fallas(Id_Tipo_Falla, Tipo_Falla, Descripcion) VALUES
(1, "Equipo", "La falla se desarrolla en el equipo"),
(2, "Accesorio", "Falla el accesorio usado en el equipo"),
(3, "Usuario", "Error de Usuario");

INSERT INTO categoria(Id_Categoria, Nombre_Categoria) VALUES
(1, "Terapéutico"),
(2, "Diagnóstico"),
(3, "Analítico"),
(4, "Varios");