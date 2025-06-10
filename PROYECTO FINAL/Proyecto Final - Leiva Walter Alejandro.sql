/*
PROYECTO FINAL SQL - CODERHOUSE

SE PLANTEA CREAR UNA BASE DE DATOS CON EL OBJETIVO DE MEJORAR LA GESTIÓN DEL EQUIPAMIENTO MÉDICO DE UNA INSTITUCIÓN

*/

-- GENERAMOS BASE DE DATOS --

CREATE DATABASE IF NOT EXISTS equipamientomedico_proyectofinal;
USE equipamientomedico_proyectofinal;

-- CREAMOS LAS TABLAS --

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
Resolucion_Falla MEDIUMTEXT,
Id_Proveedor INT,
FOREIGN KEY (Id_Proveedor) REFERENCES Proveedor(Id_Proveedor),
Tipo_Proveedor VARCHAR(15) GENERATED ALWAYS AS (IF(Id_Proveedor = 23, "INTERNO", "EXTERNO"))
);

CREATE TABLE Preventivos (
Id_Preventivo INT PRIMARY KEY AUTO_INCREMENT,
Id_Inventario VARCHAR(100),
FOREIGN KEY (Id_Inventario) REFERENCES Inventario(Id_Inventario),
Fecha_Preventivo DATETIME,
Observaciones MEDIUMTEXT,
Id_Proveedor INT,
FOREIGN KEY (Id_Proveedor) REFERENCES Proveedor(Id_Proveedor),
Tipo_Proveedor VARCHAR(15) GENERATED ALWAYS AS (IF(Id_Proveedor = 23, "INTERNO", "EXTERNO"))
);


CREATE TABLE inventario_auditoria (
Id_Auditoria INT PRIMARY KEY AUTO_INCREMENT,
Id_Inventario VARCHAR(100),
FOREIGN KEY (Id_Inventario) REFERENCES inventario(Id_Inventario),
Acción VARCHAR(100),
Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Usuario VARCHAR(100)
);

-- INSERTAMOS DATOS EN TABLAS --

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
("Medtronic"),
("INTERNO");

INSERT INTO fallas(Id_Tipo_Falla, Tipo_Falla, Descripcion) VALUES
(1, "Equipo", "La falla se desarrolla en el equipo"),
(2, "Accesorio", "Falla el accesorio usado en el equipo"),
(3, "Usuario", "Error de Usuario");

INSERT INTO categoria(Id_Categoria, Nombre_Categoria) VALUES
(1, "Terapéutico"),
(2, "Diagnóstico"),
(3, "Analítico"),
(4, "Varios");

INSERT INTO criterio_plan_mantenimiento (Id_Criterio_Plan_Mantenimiento, Equipo, Valor_Funcion_Clinica, Valor_Riesgo_Asociado, Valor_Requerimiento_Mantenimiento, Antecedentes)
VALUES
(37646,"Arco_en_C",7,3,3,2), (38671,"Autoclave",2,4,4,2), (34870,"Cama_Internación",8,1,2,2), (37806,"Desfibrilador",10,5,3,2), 
(40761,"Ecógrafo",7,3,3,2), (16231,"Electrocardiógrafo",7,3,3,2), (47769,"Máquina_de_Anestesia",10,5,5,2), 
(33586,"Monitor_Multiparamétrico",7,3,2,1), (47244,"Respirador",10,5,3,2), (37645,"RX_Fijo",6,3,3,2), (37647,"RX_Rodante",6,3,3,1), 
(37618,"Tomógrafo",6,3,4,2), (44776,"Electrobisturí",9,4,3,1);

INSERT INTO inventario(Id_Inventario, Nombre_Equipo, Id_Marca, Modelo, Serie, Descripcion, 
						Id_Servicio, Id_Proveedor, Id_Categoria, Fecha_Instalacion, Frecuencia_Mantenimiento_Preventivo_meses,
                        Costo, Orden_de_Compra, Estado_Contractual, Id_Criterio_Plan_Mantenimiento, Estado_General)
VALUES 
("CSI-37646-1","Arco_en_C",4,"BV Endura","SG0129AR","Arco en C para cirugia general",5,4,2,"2011-03-27",6,75000,18956,"Propio",37646,"OPERATIVO"),
("CSI-38671-1","Autoclave",33,"VAP 5001","210419","Autoclave de Vapor de Agua",6,18,4,"2021-09-06",1,47000,49111,"Propio",38671,"OPERATIVO"),
("CSI-38671-2","Autoclave",33,"VAP 5001","210420","Autoclave de Vapor de Agua",6,18,4,"2021-09-06",1,47000,49111,"Propio",38671,"OPERATIVO"),
("CSI-34870-1","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-2","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-3","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-4","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-5","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-6","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-7","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-8","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-9","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-10","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-11","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-03-19",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-12","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2017-08-15",0,3790,43876,"Propio",34870,"OPERATIVO"),
("CSI-34870-13","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2017-08-15",0,3790,43876,"Propio",34870,"OPERATIVO"),
("CSI-34870-14","Cama_Internación",6,"SV1","5,7411E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2017-08-15",0,3790,43876,"Propio",34870,"OPERATIVO"),
("CSI-34870-15","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-16","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-17","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-18","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2017-08-15",0,3790,43876,"Propio",34870,"OPERATIVO"),
("CSI-34870-19","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-20","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-21","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-22","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-23","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-24","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2017-08-15",0,3790,43876,"Propio",34870,"OPERATIVO"),
("CSI-34870-25","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2017-08-15",0,3790,43876,"Propio",34870,"OPERATIVO"),
("CSI-34870-26","Cama_Internación",6,"SV2 Plus","6,801E+14","Cama de Internación electrohidraulica con control remoto",4,19,1,"2017-08-15",0,3790,43876,"Propio",34870,"OPERATIVO"),
("CSI-34870-27","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-28","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-29","Cama_Internación",6,"SV1","4,9671E+15","Cama de Internación electrohidraulica con control remoto",4,19,1,"2018-10-01",0,3790,47311,"Propio",34870,"OPERATIVO"),
("CSI-34870-90","Cama_Internación",6,"SV2 Plus","3,7871E+15","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-91","Cama_Internación",6,"SV2 Plus", "3787100016450206","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-92","Cama_Internación",6,"SV2 Plus","3787100016450212","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-93","Cama_Internación",6,"SV2 Plus","3787100016450215","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-94","Cama_Internación",6,"SV2 Plus","3787100016450218","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-95","Cama_Internación",6,"SV2 Plus","3787100016450219","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-96","Cama_Internación",6,"SV2 Plus","3787100016450222","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-97","Cama_Internación",6,"SV2 Plus","3787100016450224","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-98","Cama_Internación",6,"SV2 Plus","3787100016450235","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-99","Cama_Internación",6,"SV2 Plus","3787100016450241","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-100","Cama_Internación",6,"SV2 Plus","3787100016450248","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-101","Cama_Internación",6,"SV2 Plus","3787100016450253","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-102","Cama_Internación",6,"SV2 Plus","3787100016450264","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-103","Cama_Internación",6,"SV2 Plus","3787100016450266","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-104","Cama_Internación",6,"SV2 Plus","3787100016450277","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-105","Cama_Internación",6,"SV2 Plus","3787100016450278","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-106","Cama_Internación",6,"SV2 Plus","3787100016450279","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-107","Cama_Internación",6,"SV2 Plus","3787100016450285","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-108","Cama_Internación",6,"SV2 Plus","3787100016450295","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-109","Cama_Internación",6,"SV2 Plus","3787100016450170","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-34870-110","Cama_Internación",6,"SV2 Plus","3787100016450240","Cama de Internación electrohidraulica con control remoto",1,19,1,"2020-04-17",0,3790,47320,"Propio",34870,"OPERATIVO"),
("CSI-37806-1","Desfibrilador",4,"DFM100","CN32617767","Desfibrilador Bifasico",4,2,1,"2020-03-10",6,11000,4589,"Propio",37806,"OPERATIVO"),
("CSI-37806-2","Desfibrilador",4,"DFM100","CN32617971","Desfibrilador Bifasico",4,2,1,"2019-06-11",6,11000,4589,"Propio",37806,"OPERATIVO"),
("CSI-37806-3","Desfibrilador",4,"DFM100","CN32617967","Desfibrilador Bifasico",4,2,1,"2019-06-11",6,11000,4589,"Propio",37806,"OPERATIVO"),
("CSI-37806-4","Desfibrilador",4,"DFM100","CN32617961","Desfibrilador Bifasico",4,2,1,"2019-06-11",6,11000,4589,"Propio",37806,"OPERATIVO"),
("CSI-37806-5","Desfibrilador",24,"TEC-5521E","2198","Desfibrilador Bifasico",1,17,1,"2016-02-17",6,9660,877,"Propio",37806,"OPERATIVO"),
("CSI-37806-6","Desfibrilador",24,"TEC-5521E","2136","Desfibrilador Bifasico",1,17,1,"2016-02-17",6,9660,877,"Propio",37806,"OPERATIVO"),
("CSI-37806-7","Desfibrilador",4,"DFM100","CN32617960","Desfibrilador Bifasico",1,2,1,"2018-11-22",6,11000,4601,"Propio",37806,"OPERATIVO"),
("CSI-37806-8","Desfibrilador",24,"TEC-5521E","2193","Desfibrilador Bifasico",1,17,1,"2016-02-17",6,9660,877,"Propio",37806,"OPERATIVO"),
("CSI-37806-9","Desfibrilador",24,"TEC-5521E","3932","Desfibrilador Bifasico",1,17,1,"2016-02-17",6,9660,877,"Propio",37806,"OPERATIVO"),
("CSI-37806-10","Desfibrilador",4,"DFM100","CN32617973","Desfibrilador Bifasico",1,2,1,"2018-11-22",6,11000,4601,"Propio",37806,"OPERATIVO"),
("CSI-37806-11","Desfibrilador",4,"DFM100","CN32617963","Desfibrilador Bifasico",1,2,1,"2018-11-22",6,11000,4601,"Propio",37806,"OPERATIVO"),
("CSI-37806-12","Desfibrilador",24,"TEC-5521E","2138","Desfibrilador Bifasico",5,17,1,"2016-02-17",6,9660,877,"Propio",37806,"OPERATIVO"),
("CSI-37806-13","Desfibrilador",4,"DFM100","CN32617959","Desfibrilador Bifasico",5,2,1,"2018-11-22",6,11000,4601,"Propio",37806,"OPERATIVO"),
("CSI-37806-14","Desfibrilador",4,"DFM100","CN32617944","Desfibrilador Bifasico",5,2,1,"2018-11-22",6,11000,4601,"Propio",37806,"OPERATIVO"),
("CSI-37806-15","Desfibrilador",4,"DFM100","CN32617974","Desfibrilador Bifasico",2,2,1,"2018-11-22",6,11000,4601,"Propio",37806,"OPERATIVO"),
("CSI-37806-16","Desfibrilador",4,"DFM100","CN32609734","Desfibrilador Bifasico",2,2,1,"2018-11-22",6,11000,4601,"Propio",37806,"OPERATIVO"),
("CSI-40761-1","Ecógrafo",34,"Xario","W5B16Z2582","Ecógrafo de uso general",3,17,2,"2009-01-01",12,17000,367,"Propio",40761,"OPERATIVO"),
("CSI-40761-2","Ecógrafo",34,"Xario 100","99D15Y5522","Ecógrafo de uso general",3,17,2,"2016-07-13",12,19000,3799,"Propio",40761,"OPERATIVO"),
("CSI-40761-3","Ecógrafo",34,"Xario 200","W5D1752891","Ecógrafo de uso general",3,17,2,"2017-09-28",12,39000,41567,"Propio",40761,"OPERATIVO"),
("CSI-40761-4","Ecógrafo",34,"Xario 200","W5F1793126","Ecógrafo de uso general",3,17,2,"2018-10-31",12,39000,41987,"Propio",40761,"OPERATIVO"),
("CSI-40761-5","Ecógrafo",34,"Aplio 300","F3C1872081","Ecógrafo de uso general",3,17,2,"2019-09-17",12,39000,43009,"Propio",40761,"OPERATIVO"),
("CSI-40761-6","Ecógrafo",34,"Aplio A WHC","4SB2212185","Ecógrafo de uso general",3,17,2,"2022-07-27",12,42000,43879,"Propio",40761,"OPERATIVO"),
("CSI-40761-7","Ecógrafo",34,"Xario 100","99C1595095","Ecógrafo de uso general",3,17,2,"2016-02-25",12,39000,3799,"Propio",40761,"OPERATIVO"),
("CSI-40761-8","Ecógrafo",34,"Xario 100G","WBC2392871","Ecógrafo de uso general",3,17,2,"2024-10-07",12,39000,57690,"Propio",40761,"OPERATIVO"),
("CSI-16231-1","Electrocardiógrafo",9,"ELI 230","1,16E+11","Electrocardiógrafo multicanal",4,21,2,"2017-01-16",12,5000,44157,"Propio",16231,"OPERATIVO"),
("CSI-16231-2","Electrocardiógrafo",8,"FT-1","1060003169","Electrocardiógrafo multicanal",1,11,2,"2020-03-16",12,6000,47111,"Propio",16231,"OPERATIVO"),
("CSI-16231-3","Electrocardiógrafo",8,"FT-1","1062000629","Electrocardiógrafo multicanal",1,11,2,"2020-03-16",12,6000,47111,"Propio",16231,"OPERATIVO"),
("CSI-16231-4","Electrocardiógrafo",8,"FT-1","1062000626","Electrocardiógrafo multicanal",1,11,2,"2020-03-16",12,6000,47111,"Propio",16231,"OPERATIVO"),
("CSI-16231-5","Electrocardiógrafo",8,"FT-1","1060003314","Electrocardiógrafo multicanal",1,11,2,"2020-03-16",12,6000,47111,"Propio",16231,"OPERATIVO"),
("CSI-16231-6","Electrocardiógrafo",8,"FT-1","1062000622","Electrocardiógrafo multicanal",1,11,2,"2020-03-16",12,6000,47111,"Propio",16231,"OPERATIVO"),
("CSI-16231-7","Electrocardiógrafo",8,"FT-1","1062000627","Electrocardiógrafo multicanal",1,11,2,"2020-10-30",12,6000,47111,"Propio",16231,"OPERATIVO"),
("CSI-16231-8","Electrocardiógrafo",8,"FT-1","1060003315","Electrocardiógrafo multicanal",1,11,2,"2020-10-30",12,6000,47111,"Propio",16231,"OPERATIVO"),
("CSI-16231-9","Electrocardiógrafo",9,"ELI 250","1,17E+11","Electrocardiógrafo multicanal",2,21,2,"2018-07-04",12,5700,45113,"Propio",16231,"OPERATIVO"),
("CSI-16231-10","Electrocardiógrafo",9,"ELI 250","1,15E+11","Electrocardiógrafo multicanal",2,21,2,"2018-10-02",12,5700,45113,"Propio",16231,"OPERATIVO"),
("CSI-16231-11","Electrocardiógrafo",9,"ELI 250","1,16E+11","Electrocardiógrafo multicanal",4,21,2,"2017-01-16",12,5700,44266,"Propio",16231,"OPERATIVO"),
("CSI-16231-13","Electrocardiógrafo",9,"ELI 250","1,17E+11","Electrocardiógrafo multicanal",4,21,2,"2017-06-07",12,5700,45113,"Propio",16231,"OPERATIVO"),
("CSI-16231-14","Electrocardiógrafo",9,"ELI 280","1,21E+11","Electrocardiógrafo multicanal",1,21,2,"2021-07-26",12,5800,50334,"Propio",16231,"OPERATIVO"),
("CSI-47769-1","Máquina_de_Anestesia",2,"Fabius Plus","ASEE-0188","Máquina de anestesia de uso general",5,3,1,"2014-01-01",12,24000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-2","Máquina_de_Anestesia",2,"Fabius Plus","ASFA-0047","Máquina de anestesia de uso general",5,3,1,"2014-01-01",12,24000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-3","Máquina_de_Anestesia",2,"Fabius Plus","ASDJ-0121","Máquina de anestesia de uso general",5,3,1,"2014-01-01",12,24000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-4","Máquina_de_Anestesia",2,"Fabius Plus","ASDJ-0119","Máquina de anestesia de uso general",5,3,1,"2014-01-01",12,24000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-5","Máquina_de_Anestesia",2,"Fabius Plus","ASEE-0189","Máquina de anestesia de uso general",5,3,1,"2014-01-01",12,24000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-6","Máquina_de_Anestesia",2,"Fabius Plus","ASFA-0048","Máquina de anestesia de uso general",5,3,1,"2014-01-01",12,24000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-7","Máquina_de_Anestesia",2,"Fabius Plus","ASFA-0049","Máquina de anestesia de uso general",5,3,1,"2014-01-01",12,24000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-8","Máquina_de_Anestesia",2,"Fabius Plus XL","ASKE-0156","Máquina de anestesia de uso general",5,3,1,"2017-11-01",12,28000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-9","Máquina_de_Anestesia",2,"Fabius Plus XL","ASKE-0157","Máquina de anestesia de uso general",5,3,1,"2017-11-01",12,28000,20487,"Propio",47769,"OPERATIVO"),
("CSI-47769-10","Máquina_de_Anestesia",2,"Atlan 350","ASSD-0140","Máquina de anestesia de uso general",5,3,1,"2023-07-26",12,31000,43678,"Propio",47769,"OPERATIVO"),
("CSI-47769-11","Máquina_de_Anestesia",2,"Atlan 350","ASSD-0141","Máquina de anestesia de uso general",5,3,1,"2023-07-26",12,31000,43678,"Propio",47769,"OPERATIVO"),
("CSI-47769-12","Máquina_de_Anestesia",2,"Atlan 350", "ASSD-0142","Máquina de anestesia de uso general",5,3,1,"2023-07-26",12,31000,43678,"Propio",47769,"OPERATIVO"),
("CSI-33586-1","Monitor_Multiparamétrico",2,"Infinity Delta","6006230475","Monitor Multiparamétrico de Cabecera",4,3,2,"2013-01-05",12,3500,38567,"Propio",33586,"OPERATIVO"),
("CSI-33586-2","Monitor_Multiparamétrico",2,"Infinity Delta","6009433170","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-3","Monitor_Multiparamétrico",2,"Infinity Delta","6005580473","Monitor Multiparamétrico de Cabecera",4,3,2,"2014-01-04",12,3500,38997,"Propio",33586,"OPERATIVO"),
("CSI-33586-4","Monitor_Multiparamétrico",2,"Infinity Vista XL","6001518674","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-5","Monitor_Multiparamétrico",2,"Infinity Vista XL","6004936662","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-6","Monitor_Multiparamétrico",1,"ePM12" ,"AC6-2A033353","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-7","Monitor_Multiparamétrico",1,"ePM12" ,"AC6-2A033690","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-8","Monitor_Multiparamétrico",1,"ePM12" ,"AC6-2A033692","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-9","Monitor_Multiparamétrico",1,"ePM12" ,"AC6-2A033344","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-11","Monitor_Multiparamétrico",1,"ePM12" ,"AC6-2A033695","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-12","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031639","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-13","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031643","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-14","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031642","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-15","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031647","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-16","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031641","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-17","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031638","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-18","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031644","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-19","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031650","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-20","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031640","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-21","Monitor_Multiparamétrico",1,"ePM12" ,"AC9-23031646","Monitor Multiparamétrico de Cabecera",4,1,2,"2023-10-10",12,3800,42997,"Propio",33586,"OPERATIVO"),
("CSI-33586-22","Monitor_Multiparamétrico",2,"Infinity Vista XL","6001251567","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-23","Monitor_Multiparamétrico",2,"Infinity Vista XL","6001471777","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-24","Monitor_Multiparamétrico",2,"Infinity Delta","6005579466","Monitor Multiparamétrico de Cabecera",4,3,2,"2014-03-01",12,3500,38997,"Propio",33586,"OPERATIVO"),
("CSI-33586-25","Monitor_Multiparamétrico",2,"Infinity Vista XL","6002737961","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-26","Monitor_Multiparamétrico",2,"Infinity Delta","6006176578","Monitor Multiparamétrico de Cabecera",4,3,2,"2014-01-03",12,3500,38997,"Propio",33586,"OPERATIVO"),
("CSI-33586-27","Monitor_Multiparamétrico",2,"Infinity Delta","6002679286","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-28","Monitor_Multiparamétrico",2,"Infinity Delta XL","6009432670","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-29","Monitor_Multiparamétrico",2,"Infinity Vista XL","6002744071","Monitor Multiparamétrico de Cabecera",4,3,2,"2019-12-01",12,3500,40115,"Propio",33586,"OPERATIVO"),
("CSI-33586-30","Monitor_Multiparamétrico",2,"Infinity Delta","6005578369","Monitor Multiparamétrico de Cabecera",4,3,2,"2014-03-01",12,3500,38997,"Propio",33586,"OPERATIVO"),
("CSI-33586-31","Monitor_Multiparamétrico",1,"uMec 12","KQ-81008995","Monitor Multiparamétrico de Transporte",4,1,2,"2017-08-15",12,1600,39123,"Propio",33586,"OPERATIVO"),
("CSI-33586-32","Monitor_Multiparamétrico",1,"iMEC10","EX9C076112","Monitor Multiparamétrico de Transporte",4,1,2,"2017-08-15",12,1900,39123,"Propio",33586,"OPERATIVO"),
("CSI-33586-33","Monitor_Multiparamétrico",1,"iMEC10","EX9C076113","Monitor Multiparamétrico de Transporte",4,1,2,"2018-03-19",12,1900,41433,"Propio",33586,"OPERATIVO"),
("CSI-47244-1","Respirador",2,"V300","ASFA-0030","Respirador Mecánico para Ventilación Invasiva",4,3,1,"2014-06-09",12,12000,21467,"Propio",47244,"OPERATIVO"),
("CSI-47244-2","Respirador",2,"V300","ASFA-0031","Respirador Mecánico para Ventilación Invasiva",4,3,1,"2014-06-09",12,12000,21467,"Propio",47244,"OPERATIVO"),
("CSI-47244-3","Respirador",2,"V300","ASFA-0032","Respirador Mecánico para Ventilación Invasiva",4,3,1,"2014-06-09",12,12000,21467,"Propio",47244,"OPERATIVO"),
("CSI-47244-4","Respirador",2,"V300","ASFE-0003","Respirador Mecánico para Ventilación Invasiva",4,3,1,"2014-07-31",12,12000,21489,"Propio",47244,"OPERATIVO"),
("CSI-47244-5","Respirador",2,"V300","ASFE-0004","Respirador Mecánico para Ventilación Invasiva",4,3,1,"2014-07-31",12,12000,21489,"Propio",47244,"OPERATIVO"),
("CSI-47244-6","Respirador",15,"Servo U","22708","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2016-07-24",12,13700,21966,"Propio",47244,"OPERATIVO"),
("CSI-47244-7","Respirador",15,"Servo U","22709","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2016-07-24",12,13700,21966,"Propio",47244,"OPERATIVO"),
("CSI-47244-8","Respirador",15,"Servo Air","12735","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2018-06-01",12,13700,22221,"Propio",47244,"OPERATIVO"),
("CSI-47244-9","Respirador",15,"Servo Air","12728","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2018-11-05",12,13700,22634,"Propio",47244,"OPERATIVO"),
("CSI-47244-10","Respirador",15,"Servo I","85073","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2018-11-05",12,13700,22634,"Propio",47244,"OPERATIVO"),
("CSI-47244-11","Respirador",15,"Servo I","85074","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2018-11-05",12,13700,22634,"Propio",47244,"OPERATIVO"),
("CSI-47244-12","Respirador",4,"Trilogy 202","TV01706090F","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2017-10-11",12,10800,22066,"Propio",47244,"OPERATIVO"),
("CSI-47244-13","Respirador",2,"Evita 4","ASBF-0063","Respirador Mecánico para Ventilación Invasiva",4,3,1,"2010-01-01",12,11900,19234,"Propio",47244,"OPERATIVO"),
("CSI-47244-14","Respirador",15,"Servo Air","21809","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2021-07-02",12,13700,23117,"Propio",47244,"OPERATIVO"),
("CSI-47244-15","Respirador",15,"Servo Air","21813","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2021-07-02",12,13700,23117,"Propio",47244,"OPERATIVO"),
("CSI-47244-16","Respirador",15,"Servo Air","21814","Respirador Mecánico para Ventilación Invasiva",4,2,1,"2021-07-02",12,13700,23117,"Propio",47244,"OPERATIVO"),
("CSI-47244-17","Respirador",1,"SV300","GB-86006161","Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo",4,1,1,"2018-12-19",12,13000,49876,"Propio",47244,"OPERATIVO"),
("CSI-47244-18","Respirador",1,"SV300","GB-86006158","Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo",4,1,1,"2018-12-19",12,13000,49876,"Propio",47244,"OPERATIVO"),
("CSI-47244-19","Respirador",1,"SV300","GB-86006167","Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo",4,1,1,"2018-12-19",12,13000,49876,"Propio",47244,"OPERATIVO"),
("CSI-47244-20","Respirador",1,"SV300","GB-86006168","Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo",4,1,1,"2019-08-16",12,13000,49876,"Propio",47244,"OPERATIVO"),
("CSI-47244-21","Respirador",2,"Carina","ASDF-0031","Respirador de Transporte",4,3,1,"2014-06-09",12,9800,21467,"Propio",47244,"OPERATIVO"),
("CSI-47244-22","Respirador",2,"Carina","ASCK-0017","Respirador de Transporte",4,3,1,"2014-06-09",12,9800,21467,"Propio",47244,"OPERATIVO"),
("CSI-37645-1","RX_Fijo",4,"Digital Diagnost C90","RX0459AR","Equipo de Rayos X Fijo Digital",3,9,2,"2023-05-08",6,138000,43466,"Propio",37645,"OPERATIVO"),
("CSI-37647-1","RX_Rodante",25,"DRX Revolution","54840498","Equipo de Rayos X Rodante Digital",3,10,2,"2017-08-01",12,60000,39156,"Propio",37647,"OPERATIVO"),
("CSI-37647-2","RX_Rodante",25,"DRX Revolution","58077168","Equipo de Rayos X Rodante Digital",3,10,2,"2020-09-23",12,60000,41789,"Propio",37647,"OPERATIVO"),
("CSI-37618-1","Tomógrafo",3,"Brightspeed","CT377690HM","Tomógrafo de 16 cortes",3,7,2,"2014-10-01",4,230000,19786,"Propio",37618,"OPERATIVO"),
("CSI-44776-1","Electrobisturí",16,"Force FX","F7B52322A","Electrobisturí Monopolar y Bipolar",5,22,1,"2011-01-10",12,12000,19456,"Propio",44776,"OPERATIVO"),
("CSI-44776-2","Electrobisturí",16,"Force FX","F7B52320A","Electrobisturí Monopolar y Bipolar",5,22,1,"2011-01-10",12,12000,19456,"Propio",44776,"OPERATIVO"),
("CSI-44776-3","Electrobisturí",16,"Force FX","S3D08693AX","Electrobisturí Monopolar y Bipolar",5,22,1,"2011-01-10",12,12000,19456,"Propio",44776,"OPERATIVO"),
("CSI-44776-4","Electrobisturí",16,"Force FX-8CS","S5F17877AX","Electrobisturí Monopolar y Bipolar",5,22,1,"2015-04-12",12,12000,33759,"Propio",44776,"OPERATIVO"),
("CSI-44776-5","Electrobisturí",16,"Force FX-8CS","S5H18803AX","Electrobisturí Monopolar y Bipolar",5,22,1,"2016-02-15",12,12000,33759,"Propio",44776,"OPERATIVO"),
("CSI-44776-6","Electrobisturí",16,"Force FX-8CS","S5H18795AX","Electrobisturí Monopolar y Bipolar",5,22,1,"2016-02-15",12,12000,33759,"Propio",44776,"OPERATIVO"),
("CSI-44776-7","Electrobisturí",16,"Force FX-8CS","S5H18796AX","Electrobisturí Monopolar y Bipolar",5,22,1,"2016-02-15",12,12000,38904,"Propio",44776,"OPERATIVO"),
("CSI-44776-9","Electrobisturí",16,"Force FX-8CS","S6J23863AX","Electrobisturí Monopolar y Bipolar",5,22,1,"2017-06-03",12,12000,39904,"Propio",44776,"OPERATIVO");

INSERT INTO correctivos(Id_Inventario, Fecha_Inicio_Correctivo, Fecha_Fin_Correctivo, Id_Tipo_Falla, Estado_Correctivo, Descripcion_Falla, Resolucion_Falla, Id_Proveedor) 
VALUES
('CSI-47244-17', '2023-09-07', '2023-09-07', '1', 'Finalizado', 'Fuga.', 'Cambio de parte externa de v�lvula de inspiraci�n.', '1'),
('CSI-47769-10', '2023-09-13', '2023-09-13', '3', 'Finalizado', 'Se escucha fuga.', 'La fuga era en el poliducto. Se realiza test de fugas en el equipo de manera preventiva.', '23'),
('CSI-47244-17', '2023-09-19', '2023-09-20', '3', 'Finalizado', 'Fuga excesiva de 589ml/min durante la comprobaci�n de funcionamiento.', 'Se realizo varias veces el procedimiento de comprobacion con las mismas tubuladuras y llego a una fuga aceptable de 197ml/min', '23'),
('CSI-47244-17', '2023-09-26', '2023-12-28', '1', 'Finalizado', 'Falla ""Tubo desconectado""', 'Se chequea y no se puede replicar falla. Igualmente queda en observacion y se pide etiquetar como ultimo recurso hasta que se pueda enviar a fabrica.', '1'),
('CSI-37806-3', '2023-09-27', '2023-09-27', '2', 'Finalizado', 'Falla de m�dulo ECG.', 'Reemplazo de cable paciente ECG.', '23'),
('CSI-40761-2', '2023-10-02', '2023-10-05', '1', 'Finalizado', 'Ruedas trabadas con suciedad.', 'Se saco la suciedad, no se encontraba frenado', '23'),
('CSI-37806-2', '2023-10-12', '2023-10-17', '3', 'Finalizado', 'No registra al paciente.', 'No se encontr� falla.', '23'),
('CSI-47244-5', '2023-10-18', '2025-04-08', '1', 'Finalizado', 'Mal pantalla.', '13/06/2024 - Se retiraron reguladores de presi�n del bloque del nebulizador a los fines de reparar otro ventilador ( caso 00399), por lo que debe reemplazarse esa parte. 10/07/2024 - Personal de Drager realiza revisi�n completa del equipo. Hasta el moment se confirma que necesita dos reguladores de presi�n del bloque nebulizador, y se retira la pantalla para evaluar en su taller que componentes de la misma est�n fallando, para luego enviar presupuesto por partes. 17/07/2024: A la espera de un presupuesto de reparaci�n.28/10/24 Se intercambia disco rigido de la pantalla con el disco de la pantalla del ASFA-0030 dado que el de este supone una falla en el equipo. // 8/4/2025: Se reemplazan las partes da�adas y el equipo queda operativo', '3'),
('CSI-47244-2', '2023-10-18', '2023-10-27', '3', 'Finalizado', 'No registra valores medidos.', '', '3'),
('CSI-47769-1', '2023-10-20', '2023-10-24', '1', 'Finalizado', 'Falla de calibraci�n O2.', 'Se reemplaz� la celda de O2.', '23'),
('CSI-40761-3', '2023-11-29', '2023-11-29', '1', 'Finalizado', 'El transductor tiene el cubrecable desplazado', 'Se acomodo el cubrecable en el lugar y coloque gotita', '23'),
('CSI-37806-2', '2023-11-30', '2023-11-30', '3', 'Finalizado', 'No registra ECG', 'No se encontr� falla.', '23'),
('CSI-37806-16', '2023-12-04', '2023-12-04', '2', 'Finalizado', 'Cable pelado', 'Se repara cable de palas a la salida de conector.', '23'),
('CSI-37806-3', '2023-12-20', '2023-12-22', '2', 'Finalizado', 'Mal cable ECG', 'Recambio de cable ECG', '23'),
('CSI-34870-4', '2024-01-02', '2024-01-02', '1', 'Finalizado', 'No funciona', 'Se reemplaz� control de baranda derecha', '23'),
('CSI-34870-3', '2024-01-02', '2024-01-16', '1', 'Finalizado', 'No funciona', 'Cable de control de piecera con falso contacto, hay que cambiarlo. Se pide habitacion libre para trabajar.', '23'),
('CSI-40761-2', '2024-01-03', '2024-01-03', '1', 'Finalizado', 'Se queda en pantalla de Windows', 'Emilio reinstalo el software y soluciono la falla, tambien realizo la limpieza de trackball y filtros de aire', '20'),
('CSI-47244-14', '2024-01-03', '2024-01-04', '1', 'Finalizado', '', 'Celda de O2 a 35%. Realizaron actualizacion de Soft', '2'),
('CSI-47244-15', '2024-01-03', '2024-01-04', '1', 'Finalizado', '', 'Celda de O2 a 95%. Realizaron actualizacion de Soft', '2'),
('CSI-47244-16', '2024-01-03', '2024-01-04', '1', 'Finalizado', '', 'Celda de O2 a 56%. Realizaron actualizacion de Soft', '2'),
('CSI-47244-7', '2024-01-03', '2024-01-04', '1', 'Finalizado', '', 'Celda de O2 a 65%. Realizaron actualizacion de Soft', '2'),
('CSI-37806-1', '2024-01-16', '2024-01-16', '1', 'Finalizado', 'No funciona', 'Estaba en el menu de servicio en ingles, realice 3 veces el test de funcionamiento, cambie el papel de la impresora y quedo operativo', '23'),
('CSI-34870-11', '2024-01-16', '2024-01-17', '1', 'Finalizado', 'No funciona', 'Reseteo', '23'),
('CSI-47769-10', '2024-01-17', '2024-01-17', '1', 'Finalizado', '', 'Chequeo de funcionamiento por p�rdida de agua en el techo.', '23'),
('CSI-37806-16', '2024-01-19', '2024-01-19', '3', 'Finalizado', 'Los medicos querian informacion del ultimo paciente', 'Imprimimos los sucesos desde 18Ene 23hs hasta el 19ene 03:29:22hs', '23'),
('CSI-34870-15', '2024-01-30', '2024-01-30', '1', 'Finalizado', 'No funciona', 'Cambio control de baranda.', '23'),
('CSI-16231-2', '2024-02-04', '2024-02-05', '3', 'Finalizado', 'Ruido?', 'No se encontr� falla.', '23'),
('CSI-16231-5', '2024-02-04', '2024-02-05', '3', 'Finalizado', 'Ruido?', 'No se encontr� falla.', '23'),
('CSI-16231-6', '2024-02-04', '2024-02-05', '3', 'Finalizado', 'Ruido?', 'No se encontr� falla.', '23'),
('CSI-47244-14', '2024-02-06', '2024-02-22', '2', 'Finalizado', 'Falla celda O2', 'No tenemos stock de celda. Queda Fuera de servicio. Reemplaz� Celda O2 Agimed', '2'),
('CSI-47244-9', '2024-02-06', '2024-05-15', '1', 'Finalizado', 'Falla celda O2', 'No tenemos stock de celda. Queda Fuera de servicio', '23'),
('CSI-47244-17', '2024-02-06', '2024-02-06', '1', 'Finalizado', 'Fuga de 400', 'Se calibr� sensor de flujo y baj� la fuga a 276, pero no queda confiable.', '1'),
('CSI-34870-6', '2024-02-08', '2024-02-09', '1', 'Finalizado', 'Cama tildada', 'Desbloqueo', '23'),
('CSI-34870-11', '2024-02-09', '2024-02-09', '1', 'Finalizado', 'Cama no funciona', 'Reemplazo de control baranda.', '23'),
('CSI-47244-16', '2024-02-09', '2024-05-15', '2', 'Finalizado', 'En el control preliminar ""Se ha detectado mas del 25% de O2 en el suministro de aire. No se puede comprobar la celula de o""', 'No tenemos stock de celda. Queda Fuera de servicio', '23'),
('CSI-16231-6', '2024-02-11', '2024-02-14', '1', 'Finalizado', 'No funciona', 'Se cambio del cable de paciente porque el que tenia era de banana con un adaptador que no sirve al momento de conectar el electrodo', '23'),
('CSI-34870-11', '2024-02-14', '2024-02-15', '1', 'Finalizado', 'Se tilda', 'Se reemplazaron ambos controles de baranda.', '23'),
('CSI-47244-17', '2024-02-19', '2024-12-13', '1', 'Finalizado', 'Fuga de 334', 'Con la tubuladura gris 349, con la descartable sin extender 253, con descartable extendida 375. NO usar hasta que lo vea Tecnoimagen. // Entreg� Tecnoimagen 13/12', '1'),
('CSI-16231-4', '2024-02-20', '2024-02-20', '1', 'Finalizado', 'Papel atascado', 'Se limpio la impresora y quedo funcional', '23'),
('CSI-40761-2', '2024-02-20', '2024-02-20', '2', 'Finalizado', 'El transductor convexo tiene sombra negra en la parte superior', 'Se reemplazo el transductor convexo por el Eco de la sala 4, en la sala 4 se instalo uno nuevo que tenia Maris (se lo dio Eugenia)', '23'),
('CSI-47244-6', '2024-02-20', '2024-02-21', '1', 'Finalizado', 'Fuga interna, revise el cassete espiracion', 'El Cassete esta bien instalado pero sigue dando el error en el Preliminar. Agimed Repar�', '2'),
('CSI-34870-15', '2024-02-21', '2024-02-21', '1', 'Finalizado', 'No funciona', 'Reseteo', '23'),
('CSI-47769-10', '2024-02-28', '2024-02-28', '1', 'Finalizado', 'No pasa test', 'Fuga en circuito descartable.', '23'),
('CSI-47769-4', '2024-03-01', '2024-03-01', '3', 'Finalizado', 'Fuga', 'Estaba mal colocado el vaso de la Cal sodada', '23'),
('CSI-34870-7', '2024-03-12', '2024-03-12', '1', 'Finalizado', 'Cama bloqueada, parpadean todos los leds', 'Se reemplazo el control de la barabda derecha', '23'),
('CSI-47244-15', '2024-03-15', '2024-03-15', '1', 'Finalizado', 'Error de toma de aire.', 'No se replic� falla, pero se nota ruido escesivo en la toma de aire.Se reacomod� filtro de entrada de aire. Dej� de hacer ruido en la toma. Se deja operativo pero en observaci�n.', '23'),
('CSI-47244-11', '2024-03-19', '2024-03-19', '3', 'Finalizado', 'No calibra O2, pide password.', 'Se cheque� y no pidi� password para calibrar durante ventilaci�n.', '23'),
('CSI-34870-6', '2024-03-21', '2024-03-21', '1', 'Finalizado', 'no funcionan algunos botones de ambas barandas', 'reemplazo de paneles de las 2 barandas', '23'),
('CSI-16231-2', '2024-03-21', '2024-03-21', '3', 'Finalizado', 'No imprime', 'Papel al reves, chequeo con simulador', '23'),
('CSI-37647-2', '2024-03-21', '2024-03-21', '1', 'Finalizado', 'Reemplazo de papel t�rmico. Trabajo solicitado por el fabricante. Adem�s se repar� el sistema de liberaci�n de rueda derecha para poder movilizar el equipo sin inconveniente.', '', '10'),
('CSI-34870-6', '2024-03-22', '2024-03-22', '1', 'Finalizado', 'movimientos bloqueados', 'Se desbloquea', '23'),
('CSI-47244-9', '2024-03-22', '2024-03-22', '3', 'Finalizado', 'Cartel de no funciona.', 'No se encontr� falla.', '23'),
('CSI-34870-4', '2024-03-22', '2024-03-22', '1', 'Finalizado', 'No funciona movimiento desde control de baranda', 'Reemplazo de control', '23'),
('CSI-47244-16', '2024-03-22', '2024-03-25', '2', 'Finalizado', 'No calibra O2.', 'No se replica falla. (Celda mal)', '23'),
('CSI-34870-6', '2024-03-25', '2024-03-25', '1', 'Finalizado', 'Cama bloqueada.', 'No desbloquyea. Se pide cambio de cama para analizar con mas detalle. Se reemplaza control baranda izquierda.', '23'),
('CSI-40761-4', '2024-03-25', '2024-03-25', '3', 'Finalizado', 'No frena bien.', 'No se detect� falla.', '23'),
('CSI-37806-16', '2024-03-25', '2024-03-25', '2', 'Finalizado', 'Se reporta problemas de lectura de ECG en Desfibrilador.', 'Se detecta un latiguillo del cable de ECG da�ado. Se reemplaza el cable de ECG.', '23'),
('CSI-37806-7', '2024-03-27', '2024-03-27', '3', 'Finalizado', 'No imprime', 'Se le quito un poco de volumen al rollo de papel y funciono correctamente', '23'),
('CSI-47244-14', '2024-04-02', '2024-04-02', '3', 'Finalizado', 'Falla sensor de cassette espiratorio.', 'Se realizan chequeos de rutina en el equipo y no se replica la falla. Se busca en el historial de alarmas y no se encuentra un aviso que tenga relaci�n con el cassette espiratorio. Equipo queda operativo en servicio.', '23'),
('CSI-37647-2', '2024-04-05', '2024-04-09', '1', 'Finalizado', 'Manija de detector se mueve', 'se partio un pedazo del plaztico de la base en donde se fija la manija. Se reporta caso, el equipo sigue operativo.', '10'),
('CSI-33586-8', '2024-04-10', '2024-04-10', '1', 'Finalizado', 'No mide PI', 'Se habilitan par�metros invasivos desde el men� de f�brica.', '23'),
('CSI-34870-16', '2024-03-29', '2024-04-12', '1', 'Finalizado', 'Tildada, la subi� mantenimiento.', 'Reemplazo de cable de control de enfermer�a.', '23'),
('CSI-37647-2', '2024-04-15', '2024-06-04', '1', 'Finalizado', 'La bateria se agota r�pido.', 'Carestream cambia bater�as el 4/6', '10'),
('CSI-47769-11', '2024-04-16', '2024-04-16', '1', 'Finalizado', '', 'Reemplazo de Vaporizador', '23'),
('CSI-47244-11', '2024-04-15', '2024-04-16', '2', 'Finalizado', 'Falla de O2.', 'El equipo funciona sin inconvenientes. La celda de O2 est� agotada, pero se puede utilizar. Kinesiologia est� avisado, lo rotularon el fin de semana.', '23'),
('CSI-34870-11', '2024-04-17', '2024-04-17', '1', 'Finalizado', 'Cama tildada.', 'Reemplazo de control baranda.', '23'),
('CSI-47244-11', '2024-04-19', '2024-04-19', '2', 'Finalizado', 'Falla de O2.', 'El proveedor reemplaza celda de O2.', '2'),
('CSI-47244-16', '2024-04-19', '2024-04-19', '2', 'Finalizado', 'Falla de O2.', 'El proveedor reemplaza celda de O2.', '2'),
('CSI-47769-9', '2024-04-19', '2024-04-19', '1', 'Finalizado', '', 'Reemplazo de Vaporizador', '23'),
('CSI-16231-2', '2024-04-24', '2024-04-24', '2', 'Finalizado', 'Presenta interferencia', 'Se reemplazo el cable de paciente', '23'),
('CSI-40761-7', '2024-04-29', '2024-04-29', '1', 'Finalizado', 'No enciende', 'Error de booteo. Se soluciona con \'System Restore\' de Windows.', '23'),
('CSI-34870-4', '2024-05-06', '2024-05-06', '1', 'Finalizado', 'Tildada', 'Se reemplaza control de baranda.', '23'),
('CSI-47769-7', '2024-05-07', '2024-05-07', '1', 'Finalizado', 'Falla sensor de flujo, sensr de O2. no cierra caudalimetro de O2', 'Se reemplaza sensor de Flujo, se regula valvula de O2 del caudalimetro y se calibran los sensores. OK', '23'),
('CSI-16231-5', '2024-05-07', '2024-05-07', '3', 'Finalizado', 'Se atasca el papel', 'No se puede replicar la falla', '23'),
('CSI-37806-2', '2024-05-15', '2024-05-15', '3', 'Finalizado', 'Error ECG', 'Se ejecuta test de funcionamiento. Se informa a servicio que tienen que realizarlo periodicamente.', '23'),
('CSI-37806-16', '2024-05-15', '2024-05-15', '3', 'Finalizado', 'No Funciona', 'Se ejecuta test de funcionamiento. Se informa a servicio que tienen que realizarlo periodicamente.', '23'),
('CSI-33586-11', '2024-05-17', '2024-05-17', '1', 'Finalizado', 'El monitor no puede configurarse para medir PVC.', 'Se visita servicio y se modifica el mosaico de la pantalla del monitor a los fines de que el usuario pueda medir PVC y Presi�n Arterial.', '23'),
('CSI-47769-7', '2024-05-17', '2024-05-17', '1', 'Finalizado', '', 'Se reemplazo el Vaporizador SN: 109880 por SN: VAP-115138', '23'),
('CSI-37806-4', '2024-05-17', '2024-05-17', '2', 'Finalizado', 'Falla ECG', 'Se reemplaza cable de ECG y se verifica la impresi�n, el papel se va corriendo de lugar.', '23'),
('CSI-47769-6', '2024-05-20', '2024-05-20', '2', 'Finalizado', 'Da fuga alta.', 'Mal circuito paciente descartable.', '23'),
('CSI-33586-3', '2024-05-27', '2024-05-27', '2', 'Finalizado', 'No mide PNI', 'Se cambio el brazalete', '23'),
('CSI-37806-2', '2024-06-03', '2024-06-03', '3', 'Finalizado', 'No imprime', 'Se arreglo el papel y la impresora funciono correctamente', '23'),
('CSI-47244-1', '2024-06-10', '2024-06-13', '1', 'Finalizado', 'El equipo presenta falla en pantalla y genera un zumbido.', 'Se revisa el equipo y se constata la falla en pantalla y el zumbido. En principio presentaria un problema en el regulador interno de presiones. Se solicita visita al proveedor. El proveedor reemplaza un regulador de presi�n del bloque del nebulizador por otro. 17/07/2024: respuestos en proceso de compra.', '3'),
('CSI-47244-3', '2024-06-10', '2024-08-01', '1', 'Finalizado', 'El equipo genera un zumbido.', 'Se revisa el equipo y se constata la falla. En principio presentaria un problema en el regulador de presiones. Se solicita asistencia al proveedor. Se debe reemplazar regulador de presi�n del bloque del nebulizador. El d�a 11/07/24 personal de Drager vuelve a revisar el respirador y confirma que solo deben reemplazarse los reguladores de presi�n del bloque nebulizador, y para ello deben enviar presupuesto por los repuestos. Tener en cuenta que estos reguladores deben setearse en 3 bares.', '3'),
('CSI-34870-20', '2024-06-13', '2024-06-25', '1', 'Finalizado', 'No funciona', 'Quemado control box. Fusibles (4A) y MOS-FETs (6R450E6). Se utilizan partes de otros Control Boxes quemados para generar una placa operativa.', '23'),
('CSI-34870-90', '2024-06-13', '2024-06-13', '1', 'Finalizado', 'No sube  ni baja el plano', 'Motores  rotos. Se reemplazan los dos motores del Plano de la cama. La misma se encontraba hace tiempo a la espera de los repuestos.', '23'),
('CSI-16231-4', '2024-07-01', '2024-07-01', '2', 'Finalizado', 'Presenta interferencia', 'Se reemplazo el cable de paciente', '23'),
('CSI-16231-8', '2024-07-01', '2024-07-01', '3', 'Finalizado', 'No funciona', 'No tenia la resma de papel.', '23'),
('CSI-47244-15', '2024-07-05', '2024-07-12', '1', 'Finalizado', 'Falla control preliminar fugas internas', 'esperando a Agimed', '2'),
('CSI-47244-22', '2024-07-10', '2024-07-10', '1', 'Finalizado', 'TSB', 'Visita por aplicaci�n de TSB Nro 15 de Drager. Se reemplaza retrofit en el equipo.', '3'),
('CSI-47244-21', '2024-07-10', '2024-07-10', '1', 'Finalizado', 'TSB', 'Visita por aplicaci�n de TSB Nro 15 de Drager. Se reemplaza retrofit en el equipo.', '3'),
('CSI-37647-1', '2024-07-11', '2024-07-29', '1', 'Finalizado', 'La bater�a del equipo se agota r�pido.', 'Se crea caso con Euroswiss. Estamos a la espera de visita.', '10'),
('CSI-40761-3', '2024-07-15', '2024-07-15', '1', 'Finalizado', '', 'Se coloco la impresora del equipo destinado a UDO', '23'),
('CSI-47769-11', '2024-07-17', '2024-07-17', '1', 'Finalizado', 'Falla en sensor de flujo.', 'Se reemplaza sensor de flujo.', '23'),
('CSI-47769-7', '2024-07-18', '2024-07-24', '1', 'Finalizado', 'Fuga en Vapo', 'Se encuentra rot�metro de O2 completamente zafado. Se cambia por mesa de backup y se deja fuera de servicio en dep�sito. Drager cambia Flujimetros de N2O x O2.', '3'),
('CSI-47769-8', '2024-07-18', '2024-07-18', '1', 'Finalizado', '', 'Se coloca en Qx3 y se le realiza un chequeo de funcionamiento. Se encuentra con bandeja de apoyo en mal estado.', '23'),
('CSI-16231-4', '2024-07-23', '2024-07-26', '1', 'Finalizado', 'Durante el mantenimiento preventivo se observa que el equipo est� imprimiendo mal. Los complejos QRS practicamente no se ven.', 'Se corrobora falla en bater�a y l�nea. La bandeja no est� presionada por la bater�a, sin embargo la impresi�n en el extremo inferior de la hoja es d�bil. Se aument� el tiempo de calentamiento del cabezal t�rmico. El equipo est� imprimiendo correctamente.', '23'),
('CSI-37806-1', '2024-07-24', '2024-07-24', '1', 'Finalizado', '', 'Se encuentra equipo con falla. Personal del servicio realiz� un test de funcionamiento con resultado err�neo y no se dio cuenta. Se avisa a coordinaci�n.', '23'),
('CSI-40761-3', '2024-07-23', '2024-07-24', '3', 'Finalizado', 'A veces enciende a veces no.', 'Se revisa el equipo pero no presenta falla.', '23'),
('CSI-37806-4', '2024-07-29', '2024-07-29', '3', 'Finalizado', 'No pasa el chequeo', 'se acomoda papel de impresi�n y se realiza chequeo', '23'),
('CSI-34870-16', '2024-08-02', '2024-08-02', '1', 'Finalizado', 'Se bloquea sola', 'se reemplazan los dos controles de las barandas a los mismos les fallaban algunas funciones.', '23'),
('CSI-33586-25', '2024-08-02', '2024-08-02', '2', 'Finalizado', 'No mide SPo2', 'Reemplazos de prolongador y sensor de SpO2', '23'),
('CSI-34870-11', '2024-08-07', '2024-08-07', '1', 'Finalizado', 'No sube la cabecera', 'Estaba trabada la palanca de CPR y se reemplaz� el control de la baranda derecha.', '23'),
('CSI-34870-1', '2024-08-12', '2024-08-12', '1', 'Finalizado', 'No se desbloquea', 'se reemplaza cable de conexi�n entre el control de enfermeros y la control box de la cama.', '23'),
('CSI-47769-12', '2024-08-13', '2024-08-13', '2', 'Finalizado', 'No pasa el chequeo', 'Se reemplazo el sensor de flujo de la parte inspiratoria.', '23'),
('CSI-40761-3', '2024-08-14', '2024-08-19', '1', 'Finalizado', 'Todos los presets presentan las mismas mediciones.', 'Se contact� a Emilio de Canon, y nos comenta que es una falla com�n y tiene que venir a reinstalar software. Se eleva pedido a Bioingenieros para que coordinen.', '20'),
('CSI-47769-7', '2024-08-16', '2024-08-16', '1', 'Finalizado', '', 'Checkeo de mesa e instalaci�n en Qx5, para liberar ASSD-0140 y que Draguer realice MP', '23'),
('CSI-47769-10', '2024-08-21', '2024-08-21', '1', 'Finalizado', '', 'Chequeo de funcionamiento e instalaci�n en Qx6 post MP', '23'),
('CSI-37647-1', '2024-08-22', '2024-10-01', '1', 'Finalizado', 'El equipo no tiene la suficiente autonom�a de baterias para hacer un recorrida.', 'Se solicita asistencia al proveedor. Se abre caso N� 1023924. El proveedor en la visita detalla que hay un banco de baterias que hay que cambiar. Se adquieren bater�as y estamos a la espera de que el proveedor las instale.// 01/10/2024 - El proveedor vino a reemplazar bater�as. Tener en cuenta que las bater�as no se las compramos a Euroswiss.', '10'),
('CSI-47769-11', '2024-08-23', '2024-08-23', '1', 'Finalizado', 'No sensa bien, el anestesiologo reinicio el equipo', 'Cuando la revisamos el equipo estaba solicitando la calibracion de flujo, se realizo el chequeo de sistema y quedo OK', '23'),
('CSI-37806-16', '2024-08-23', '2024-08-23', '2', 'Finalizado', 'Cable de ECG roto en RA', 'Se reemplazo el cable de ECG', '23'),
('CSI-47769-7', '2024-08-30', '2024-08-30', '1', 'Finalizado', 'Tiene cal Sodada en el Cosy', 'Se limpio la tapa de la valvula inspiratoria y la exhalatoria. Se cambio la Cal Sodada y le pedimos a Alejandra que cambie el metodo al reemplazar la Cal, deben fijarse que no tenga polvo', '23'),
('CSI-34870-15', '2024-08-30', '2024-08-30', '1', 'Finalizado', 'No funciona el control de enfermeria', 'Se le coloco precinto donde esta el conector del cable para que no se salga', '23'),
('CSI-16231-4', '2024-09-01', '2024-09-02', '1', 'Finalizado', 'Se perdi� un adaptador', 'Se reemplaza adaptador y se chequea funcionamiento', '23'),
('CSI-37806-1', '2024-09-12', '2024-09-12', '3', 'Finalizado', 'No pasa el Test de funcionamiento', 'Se revisaron las palas, la impresora y el cable de paciente. El equipo paso bien el test de funcionamiento', '23'),
('CSI-47244-9', '2024-09-13', '2024-10-25', '1', 'Finalizado', 'Personal de limpieza le rompio la perilla de ON/Off', 'Le desconectamos la bateria para poder apagar el equipo. ""Error en el interruptor de alimentaci�n-TE:51"". Se abri� el caso 202408496 con Agimed. Se recibe presupuesto por el repuesto. 25/10 Visita Agimed y repara.', '2'),
('CSI-47769-6', '2024-09-19', '2024-09-19', '3', 'Finalizado', 'Problemas en cable de l�nea', 'Se corrobor� que todo est� funcionando correctamente, se avis� a mantenimiento por los tomas en mal estado.', '23'),
('CSI-37806-16', '2024-09-24', '2024-09-25', '2', 'Finalizado', 'No sensa LL', 'Se reemplazo el cable de paciente', '23'),
('CSI-34870-15', '2024-09-26', '2024-09-30', '1', 'Finalizado', 'No funciona', 'Control box quemado. Se pide cambio de cama.Se reemplaz� MOSFET. Queda en dep�sito operativa.', '23'),
('CSI-47769-12', '2024-09-26', '2024-09-26', '1', 'Finalizado', 'Marca errores', 'Mesa avisaba que necesitaba realizarce chequeo de sistema. Se realiz� y qued� operativa.', '23'),
('CSI-34870-5', '2024-10-04', '2024-10-04', '1', 'Finalizado', 'Mal control baranda', 'Reemplazo de control', '23'),
('CSI-34870-1', '2024-10-08', '2024-10-08', '1', 'Finalizado', 'No funciona, tildada', 'Se reemplazan los dos controles de las barandas, los mismos daban falla en toda la cama.', '23'),
('CSI-47769-7', '2024-10-09', '2024-10-09', '3', 'Finalizado', 'El usuario reporta fuga', 'Se revisa el equipo y se realiza test de fuga con circuito nuevo. Resultado del test exitoso.', '23'),
('CSI-47769-11', '2024-10-10', '2024-10-10', '1', 'Finalizado', 'No pasa chequeo inicial.', 'Se reemplaza sensor de flujo de espiraci�n.', '23'),
('CSI-47244-13', '2024-10-10', '2024-12-06', '1', 'Finalizado', '', 'No retiene carga bater�as.// 15/10/2024 El proveedor Drager realiza taraeas de mantenimiento preventivo, y se le pide cotizaci�n por baterias para este equipo. Adem�s, el proveedor aconseja que el equipo quede en Stand By siempre, puesto que las baterias se cargan cuando el equipo est� encendido. // 23/10/2024 Se reclama cotizaci�n de baterias.// 31/10/2024: Drager reemplazar� sin costo las baterias de este equipo.Drager realizo el cambio de baterias, se deja operativo en el sector', '3'),
('CSI-47769-6', '2024-10-10', '2024-10-10', '3', 'Finalizado', 'se siente olor a sevorane y se despierta la paciente antes de comenzar la cirugia', 'Se encontro mal enrroscada la tapa donde se carga el sevorane el vaporizador funciona bien y es el de Muleto, se aprovecha para cambiarlo por uno nuestro ya calibrado S/N: VAP-115045 para QX6', '23'),
('CSI-33586-9', '2024-10-14', '2024-10-14', '1', 'Finalizado', 'Usuario aduce que el monitor no mide temperatura', 'Se revisa el equipo y se concluye que debe agregarse el par�metro temperatura en la configuraci�n de la disposici�n depar�metros en pantalla. Luego de hacer esto, se observa que el monitor mide temperatura.', '23'),
('CSI-34870-5', '2024-10-14', '2024-10-14', '1', 'Finalizado', 'No permite desbloquear la cama', 'Se reemplazo el cable del control de enfermeria y el control de la baranda derecha.', '23'),
('CSI-33586-2', '2024-10-14', '2024-10-14', '2', 'Finalizado', 'No se visualiza en la Central de monitoreo', 'Se reviso el cable de red, mantenimiento chequeo el cableado dentro del poliducto y quedo ok', '23'),
('CSI-47244-16', '2024-10-10', '2024-10-14', '1', 'Finalizado', 'Presenta fugas o diferencias de presiones, no pasa el chequeo preliminar', 'Principalmente el equipo no tiene la tubuladura de pruebas. Realice el chequeo preliminar con la manguera de otro equipo maquet y paso todo OK, lo deje ciclar y todo estuvo OK', '23'),
('CSI-16231-6', '2024-10-12', '2024-10-14', '2', 'Finalizado', 'No funciona', 'Le faltaban los adaptadores de C4 y C5.', '23'),
('CSI-47244-13', '2024-10-22', '2024-12-06', '1', 'Finalizado', 'El proveedor le realizo el mantenimiento preventivo y el equipo no inicia', 'Luego de realizado el mantenimiento preventivo el equipo present� falla en el arranque. Se reinicia antes de finalizar el encendido manteniendose en un bucle. No fue posible realizar una reinstalaci�n de software. Se pedir� la placa principal MPU para continuar el diagn�stico. //   23/10/2024 El proveedor est� a la espera de tener el repuesto necesario para volver a la cl�nica, instalarlo, y verificar que con ese reemplazo se soluciona la falla. // 30/10/2024: El proveedor realiz� una prueba de diagn�stico con la placa MPU. El equipo funcion� correctamente. Pas� satisfactoriamente los chequeos de la cartilla de pruebas y cicl� correctamente con pulm�n de pruebas. Requiere el reemplazo de Kit MPU BoardCarina. Drager cambio el repuesto y quedo el equipo operativo en el sector.', '3'),
('CSI-34870-19', '2024-10-23', '2024-10-23', '3', 'Finalizado', 'No funciona el respaldo', 'El CPR manual estaba activo. Y funciono correctamente', '23'),
('CSI-34870-16', '2024-10-24', '2025-03-06', '1', 'Finalizado', 'Se encontro bloqueada, se desbloqueo del control remoto y al rato se apago y dejo de funcionar', 'se nota que uno de los cables con la ficha que conecta el control de la baranda izquierda parece quemado, tambien se quemo el control box , el cual, se intento reparar pero amen de tener varios componentes da�ados hay uno de ellos que no se consigue. // 06/01/2025 Por mas que se tenga el control box para reemplazar, se necesita la crimpadora para reparar el cable. // 6/3/25 Se instala control box nuevo. Controles de barandas nuevos, cable de enfermer�a reacondicionado y control de enfermeria reacondicionado.', '23'),
('CSI-37647-2', '2024-10-21', '2024-10-25', '1', 'Finalizado', 'Del servicio de im�genes nos indican que, en ocasiones, el freno del tubo no funciona y el mismo queda libre.', 'Se solicita asistencia al proveedor, y se crea el caso 1055330.// 25/10/2024: Proveedor encuentra cable de freno cortado. Equipo queda operativo.', '10'),
('CSI-37647-1', '2024-10-28', '2024-11-01', '1', 'Finalizado', 'Al soltar el freno el equipo sigue su marcha', 'Se solicita asistencia al proveedor.// 01/11/2024: Proveedor asiste a la Cl�nica, se reacomodan sensores del manubrio del equipo, y el equipo queda operativo.', '10'),
('CSI-16231-2', '2024-10-30', '2024-10-30', '3', 'Finalizado', 'Imprime y para', 'Mal colocado papel en bandeja', '23'),
('CSI-16231-6', '2024-10-30', '2024-10-30', '2', 'Finalizado', 'Mucho ruido', 'Se reemplaza cable paciente.', '23'),
('CSI-34870-22', '2024-10-29', '2024-10-30', '1', 'Finalizado', 'Chapa corto zonda', 'Se recompone pin de seguridad de perno 5ta rueda.', '23'),
('CSI-47769-8', '2024-11-01', '2024-12-09', '1', 'Finalizado', 'Se rompieron las correderas metalicas de la bandeja superior de apoyo', 'David de Drager reemplaz� correderas de bandeja.', '23'),
('CSI-16231-6', '2024-11-08', '2024-11-08', '1', 'Finalizado', 'No funciona', 'Se calibro la pantalla', '23'),
('CSI-34870-1', '2024-11-12', '2024-11-13', '3', 'Finalizado', 'Cama trabada.', 'No se detecta falla', '23'),
('CSI-40761-4', '2024-11-27', '2024-11-27', '1', 'Finalizado', '', 'Se repara vaina de transductor plano en tomagoma.', '23'),
('CSI-34870-25', '2024-11-28', '2024-11-28', '1', 'Finalizado', 'Esta bloqueada', 'Desbloqueamos la cama pero no sube el respado, la cama estaba con paciente. // Se reemplaza motor cabecera.', '23'),
('CSI-34870-15', '2024-11-29', '2024-11-29', '1', 'Finalizado', 'Esta bloqueada', 'Se desbloquea la cama y se corrobora que pueda realizar todos los movimientos, quedando operativa.', '23'),
('CSI-34870-11', '2024-12-03', '2024-12-03', '1', 'Finalizado', 'Cama bloqueada', 'Se reemplaza control de baranda derecha.', '23'),
('CSI-33586-3', '2024-12-12', '2024-12-12', '1', 'Finalizado', 'No mide PNI', 'Se reemplaza bomba y v�lvulas', '23'),
('CSI-34870-6', '2024-12-29', '2024-12-30', '1', 'Finalizado', 'La cama se encuentra bloqueada', 'Se reemplazan los controles de barandas derecha e izquierda.', '23'),
('CSI-37647-1', '2024-12-30', '2025-01-03', '1', 'Finalizado', 'El equipo arroja un cartel de calibraci�n del detector. Adem�s presenta problemas con el freno. Cuando vas en marcha se frena.', 'Se solicita asistencia al proveedor.// 03/01/2025: Personal de Euroswiss realiza calibraci�n del detector, y se ajustan los resortes que activan el freno en la manija del equipo. Equipo operativo.', '10'),
('CSI-34870-6', '2025-01-06', '2025-03-06', '1', 'Finalizado', 'Se quedo el respaldo arriba y no funciona los comandos (Box 626)', 'Se reemplazo el control de la baranda izquierda // 13/01/25 le quitamos los controles de baranda y el cable de enfermeria // 6/3/25 Se instala cable de control de enfermeria y controles de baranda reacondicionados.', '23'),
('CSI-34870-3', '2025-01-12', '2025-01-13', '1', 'Finalizado', '', 'Se reemplazo los controles de las barandas y el cable de enfermeria', '23'),
('CSI-34870-11', '2025-01-14', '2025-01-14', '1', 'Finalizado', 'Titila', 'Se desbloquea', '23'),
('CSI-34870-11', '2025-01-15', '2025-01-15', '1', 'Finalizado', 'Sigue bloqueandose', 'Se reemplaza control de baranda derecha.', '23'),
('CSI-37806-4', '2025-01-22', '2025-01-22', '1', 'Finalizado', '', 'Se realizo el test de funcionamiento', '23'),
('CSI-47244-1', '2025-02-06', '2025-03-26', '1', 'Finalizado', 'No se visualiza la pantalla', 'No se ve imagen en la pantalla..Leer las observaciones del item 585 // 05/03/2025: se inicia proceso de compra de repuestos. // 26/03/2025 proveedor viene a la cl�nica a reparar el equipo. Se reemplaza cable LVDS, se realizan chequeos de funcionamiento, y el equipo queda operativo en el servicio', '23'),
('CSI-34870-11', '2025-02-11', '2025-02-11', '1', 'Finalizado', 'Cama bloqueada', 'Se reemplaza el control de la baranda derecha.', '23'),
('CSI-47769-9', '2025-02-11', '2025-02-14', '1', 'Finalizado', 'Fuga', 'No presento fuga pero si visualizamos que el rotametro O2 no cierra completamente, esta mesa quedo en el deposito para que la chequee Drager.', '3'),
('CSI-47244-17', '2025-01-15', '2025-02-14', '1', 'Finalizado', 'No aparece la opcion de VNI en el equipo', 'Se solicita asistencia al proveedor// 14/2/2025: se recibe licencia de activaci�n de modos ventilatorios y se la aplica al equipo. El equipo queda operativo.', '1'),
('CSI-47769-12', '2025-02-17', '2025-02-17', '3', 'Finalizado', 'Fuga', 'Mal colocada la cal sodada.', '23'),
('CSI-16231-3', '2025-02-18', '2025-02-19', '1', 'Finalizado', 'No enciende', 'Se encuentra tildado y no bootea. Se realiza reset de f�brica. Necesita bater�a nueva ya que se agota muy r�pido.', '23'),
('CSI-37806-1', '2025-02-20', '2025-02-20', '3', 'Finalizado', 'No permite realizar chequeo', 'se acomodan las paletas en su correcta posicion y se realiza el test de funcionafmiento, no presento falla', '23'),
('CSI-37806-3', '2025-03-05', '2025-03-05', '3', 'Finalizado', 'Reportan que no funciona', 'No se encuentra falla.', '23'),
('CSI-40761-8', '2025-03-11', '2025-03-11', '1', 'Finalizado', 'No enciende', 'Se resetean las termicas del equipo.', '23'),
('CSI-37806-3', '2025-03-12', '2025-03-12', '3', 'Finalizado', 'Reportan que no funciona', 'No se encuentra falla.', '23'),
('CSI-47769-10', '2025-03-19', '2025-03-19', '1', 'Finalizado', 'Arroja mensaje de falla sensor espiratorio', 'Se reemplaza sensor espiratorio. Se realizan chequeo del sistema completo, y el equipo queda operativo', '23'),
('CSI-37806-3', '2025-03-20', '2025-04-03', '1', 'Finalizado', 'El equipo queda tildado cuando se quiere ingresar al menu del test de funcionamiento.', 'Se solicita soporte al proveedor. Prioveedor no vino. Desarme completo el equipo y medi cada capacitor dado que parecia ser un problema de los mismo, no se encontraron desperfectos en los capacitores midiendo su capacidad con el multimetro Fluke, pero no se pudo realizar la prueba con el Capacheck para medir el electrolito de carga y descarga de los mismos. amen de esto se retiro la bateria de 3,3V de la Cmos para resetearla.se rearmo el equipo y al encender se reconfiguro todos los parametros y se realizaron pruebas satifactorias. se deja el equipo en el servicio', '2'),
('CSI-33586-18', '2025-03-21', '2025-05-15', '1', 'Finalizado', 'El monitor no muestra el trazado de ECG', 'Se revisa el equipo utilizando un simulador de ECG y se corrobora que el trazado se puede ver sin problemas. Sin embargo, con el paciente, el monitor no es capaz de sensar la se�al. El equipo estaba configurado para leer una se�al de un cable con 5 latiguillos, y se presume que se salen los latiguillos del paciente, puesto que no deja de moverse. Se configura el equipo para que el sensado de ECG sea autom�tico y no dependiente de que est�n si o si los 5 latiguillos conectados. Se corrobora que el equipo puede sensar ECG y ser visualizado en pantalla, y queda operativo en el servicio. // 15/5 Devuelve Tecnoimagen sin detectar problema', '1'),
('CSI-34870-3', '2025-04-01', '2025-04-01', '1', 'Finalizado', 'Cama bloqueada', 'Se reemplaza control de baranda. Cama operativa.', '23'),
('CSI-16231-7', '2025-04-14', '2025-04-22', '1', 'Finalizado', 'Se observa que al encender el equipo se apaga y no termina de inicializar nunca', '16/4/2025: se encuentra equipo cargando, se enciende y se observa que comienza a realizar algun tipo de correcci�n por motus propio. No se observa el mismo problema de apagado y encendido.// 21/4/2025: se realizan chequeos funcionales y el equipo necesita reemplazo de bateria.', '23'),
('CSI-37618-1', '2025-04-16', '2025-04-16', '1', 'Finalizado', 'El equipo se tilda y no permite trabajar. Arroja en pantalla mensaje de Waiting for scouts to be available', 'Se crea caso con GE #SR13848459. Se comunica ingeniero remoto y se realiza una reconstrucci�n de base de datos. Si el equipo presenta el mismo error hayq ue reinstalar el software del mismo y este trabajo toma 4 horas.', '7'),
('CSI-34870-16', '2025-05-05', '2025-05-06', '1', 'Finalizado', 'No se puede desbloquear la cama', 'Se retira el control izquierdo para reparar, pero la cama tiene un sonido fuerte cuando baja el plano. Se instalo el control reparado.', '23'),
('CSI-37806-6', '2025-05-07', '2025-05-07', '3', 'Finalizado', 'El servicio reporta: ""Se solicita revisar el  desfibrilador del carro de 3D ya que el mismo funciona solo cuando se lo mueve, no hace buen contacto.""', 'Se acude al servicio y se realiza revisi�n de cable de alimentaci�n y tomacorrientes, y los mismos se encuentran funcionales. Se procede con chequeo propio del equipo resultando el mismo satisfactorio.', '23'),
('CSI-37806-16', '2025-05-07', '2025-05-07', '3', 'Finalizado', 'Usuario reporta falla en el equipo', 'Las paletas estaban mal colocadas, y no pasaba el test de funcionamiento. Se acomodan las paletas y se realiza el test de funcionamiento, quedando operativo el equipo.', '23'),
('CSI-47244-19', '2025-05-07', '2025-05-08', '1', 'Finalizado', 'Falla de celda O2 en auto-test', 'Se reemplaza celda, se calibra en 2 ocasiones. Pasa auto-test, se cicla en 21% y 100% de FiO2 correctamente.', '23'),
('CSI-47769-2', '2025-05-09', '2025-05-09', '1', 'Finalizado', '', 'Se instala analizador de gases Scio4 y se retira Capnostat5, para equiparar el m�todo de medici�n de gases del resto de los quir�fanos.', '23'),
('CSI-47769-1', '2025-05-12', '2025-05-12', '1', 'Finalizado', 'No calibra la celda', 'Se reemplaza la celda de O2 y se calibra', '23'),
('CSI-37647-1', '2025-05-14', '2025-05-14', '1', 'Finalizado', 'El usuario reporta que el equipo qued� tildado en el pasillo de la UTI y no puede moverse.', 'Se revisa el equipo y se observa que hay un error de incializaci�n del sistema operativo. Se reinicia desde la bios el sistema operativo, y el equipo se enciende sin errores. Se inicia sesi�n y se observa que el equipo puede adquirir im�genes y movilizarse. El rodante queda operativo.', '23');

INSERT INTO preventivos (Id_Inventario, Fecha_Preventivo, Observaciones, Id_Proveedor) 
VALUES
('CSI-37646-1', '2022-11-21', '', '9'),
('CSI-38671-2', '2025-02-03', '', '23'),
('CSI-38671-1', '2025-02-03', '', '23'),
('CSI-37806-10', '2024-12-17', '', '23'),
('CSI-37806-5', '2024-12-18', '', '23'),
('CSI-37806-7', '2024-12-19', '', '23'),
('CSI-37806-6', '2024-12-19', 'Se debe reemplazar bateria', '23'),
('CSI-37806-12', '2025-02-11', 'Se debe reemplazar bateria', '23'),
('CSI-37806-8', '2025-01-06', '', '23'),
('CSI-37806-9', '2024-12-18', '', '23'),
('CSI-37806-15', '2024-11-07', '', '23'),
('CSI-37806-1', '2025-02-11', '', '23'),
('CSI-37806-11', '2024-11-07', '', '23'),
('CSI-37806-2', '2024-11-26', '', '23'),
('CSI-37806-16', '2024-11-26', '', '23'),
('CSI-37806-13', '2025-02-11', '', '23'),
('CSI-37806-14', '2025-02-11', '', '23'),
('CSI-37806-3', '2024-11-07', '', '23'),
('CSI-37806-4', '2024-11-20', '', '23'),
('CSI-40761-1', '2025-01-29', '', '20'),
('CSI-40761-2', '2024-07-10', 'Se observa transductor TV con �rea de sombra en la lateral de la imagen debido a cristales da�ados.', '20'),
('CSI-40761-7', '2025-01-29', 'Se recrea base de datos debido a falla: Error TUS-PIMS-4 al iniciar. Adem�s, se observa transductor lineasl PLU704BT,serie 99A1783640, con �reas de sombra en los laterales debido a cristales da�ados.', '20'),
('CSI-40761-3', '2025-02-05', 'Se observa burbuja de aire en lente ac�stica de trasnductor endovaginal PVU781VTE serie  99A1753070, en la porci�n central.', '20'),
('CSI-40761-4', '2025-01-29', 'Transductor Lineal con sombra y fisuras en carcasa po da�o en cristales. Tranductor convex con sombras en porci�n central debido a cristales da�ados.', '20'),
('CSI-40761-5', '2025-01-29', '', '20'),
('CSI-40761-6', '2025-02-05', '', '20'),
('CSI-16231-5', '2024-07-05', 'Sin SE.', '23'),
('CSI-16231-6', '2024-05-07', '', '23'),
('CSI-16231-2', '2024-05-07', '', '23'),
('CSI-16231-3', '2024-07-05', 'Sin SE.', '23'),
('CSI-16231-4', '2024-07-26', '', '23'),
('CSI-16231-8', '2024-07-23', 'Sin SE.', '23'),
('CSI-16231-7', '2024-05-23', '', '23'),
('CSI-16231-13', '2024-05-13', '', '23'),
('CSI-16231-1', '2024-05-13', '', '23'),
('CSI-16231-14', '2024-05-23', '', '23'),
('CSI-16231-9', '2024-07-04', '', '23'),
('CSI-16231-11', '2024-05-14', '', '23'),
('CSI-16231-10', '2024-06-12', '', '23'),
('CSI-37645-1', '2023-11-01', '', '9'),
('CSI-47769-8', '2024-07-24', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47769-7', '2024-09-23', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47769-5', '2024-09-23', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47769-2', '2024-10-08', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47769-6', '2024-09-23', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47769-9', '2024-07-22', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47769-1', '2024-10-08', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47769-10', '2024-08-19', 'Preventivo sin cambio de partes.', '3'),
('CSI-47769-11', '2024-07-22', 'Preventivo sin cambio de partes.', '3'),
('CSI-47769-12', '2024-08-26', 'Preventivo sin cambio de partes.', '3'),
('CSI-47769-3', '2024-12-18', 'Se reemplaz� kit de 2 a�os.', '3'),
('CSI-47769-4', '2025-01-07', 'Se reemplaz� kit de 1 a�o.', '3'),
('CSI-47244-1', '2023-11-02', 'Se reemplaz� Kit de 2 A�os.', '3'),
('CSI-47244-3', '2024-12-18', 'Se reemplaz� Kit de 2 A�os pero tenia que ser el de 3 A�os. Al tercer a�o no se le debe reemplazar partes, es solo chequeo. No se reemplaza bateria externa.', '3'),
('CSI-47244-5', '2022-08-19', '', '3'),
('CSI-47244-2', '2023-10-19', 'Se reemplaz� Kit de 2 A�os.', '3'),
('CSI-47244-22', '2024-10-23', 'Se reemplaza bater�a', '3'),
('CSI-47244-21', '2024-10-23', 'Se reemplaza bater�a', '3'),
('CSI-47244-19', '2023-11-30', '', '1'),
('CSI-47244-17', '2022-10-08', '*se lo llevaron por fuga', '1'),
('CSI-47244-20', '2023-12-05', '', '1'),
('CSI-47244-18', '2023-11-30', '', '1'),
('CSI-47244-8', '2025-01-23', 'Se le cambio la bateria, la celda de o2 y el kit de 5 mil h//  23/1/2025: Cambio de bateria y celda AA155822 - PM 3414hs, celda 99% (instalada en 01/2025)', '2'),
('CSI-47244-9', '2021-06-15', '', '2'),
('CSI-47244-14', '2025-01-23', '23/1/2025: PM 1948hs, celda 68% (instalada en 02/2024)', '2'),
('CSI-47244-15', '2025-01-23', '23/1/2025: PM 2920hs, celda 74% (instalada en 11/2023)', '2'),
('CSI-47244-16', '2025-01-23', '23/1/2025: Cambio de Kit 5000hs - PM 5000hs, celda 86% (instalada en 04/2024)', '2'),
('CSI-47244-10', '2022-08-16', '', '2'),
('CSI-47244-11', '2025-01-23', '23/1/2025: Cambio de bateria - PM 3794hs, celda 68% (04/2024)', '2'),
('CSI-47244-6', '2025-01-23', '23/1/2025: Cambio de kit 5000hs - PM 5000hs, celda 60% (instalada en 09/2023)', '2'),
('CSI-47244-7', '2025-01-23', '23/1/2025: PM 3702hs, celda 88% (05/2024)', '2'),
('CSI-47244-13', '2024-10-15', 'Se debe reemplazar bateria', '3'),
('CSI-47244-4', '2024-12-18', 'Se reemplaz� Kit de 2 A�os pero tenia que ser el de 3 A�os. Al tercer a�o no se le debe reemplazar partes, es solo chequeo. No se reemplaza bateria externa.', '3'),
('CSI-37647-1', '2025-05-16', '', '10'),
('CSI-37647-2', '2025-05-16', '', '10'),
('CSI-37618-1', '2023-08-31', '', '7'),
('CSI-44776-2', '2025-01-13', '', '22'),
('CSI-44776-1', '2025-01-13', '', '22'),
('CSI-44776-3', '2023-05-31', '', '22'),
('CSI-44776-4', '2025-01-13', '', '22'),
('CSI-44776-7', '2025-01-13', '', '22'),
('CSI-44776-9', '2025-01-13', '', '22'),
('CSI-44776-5', '2025-01-13', '', '22'),
('CSI-44776-6', '2025-01-13', '', '22');



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

-- LA VISTA ANTERIOR SE PUEDE MODIFICAR, AGREGANDO LA FECHA DE VENCIMIENTO DE LOS PREVENTIVOS
-- QUEDANDO DE ESTA FORMA

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
IN p_Resolucion_Falla MEDIUMTEXT,
IN p_Id_Proveedor INT
)
BEGIN
		DECLARE v_Estado_Correctivo VARCHAR(100);
	    IF EXISTS (SELECT 1 FROM correctivos WHERE Id_Correctivo = p_Id_Correctivo) THEN
				UPDATE correctivos SET Fecha_Fin_Correctivo = p_Fecha_Fin_Correctivo WHERE Id_Correctivo = p_Id_Correctivo;
                UPDATE correctivos SET Estado_Correctivo = p_Estado_Correctivo WHERE Id_Correctivo = p_Id_Correctivo;
                UPDATE correctivos SET Resolucion_Falla = p_Resolucion_Falla WHERE Id_Correctivo = p_Id_Correctivo;
				UPDATE correctivos SET Id_Proveedor = p_Id_Proveedor WHERE Id_Correctivo = p_Id_Correctivo;
		ELSE SELECT "ID INCORRECTO" AS mensaje;
		END IF;
      
END //

DELIMITER ;

CALL Cerrar_Correctivo (178, NOW(), "Finalizado", "Se reemplazó placa principal del WAM",23);



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


-- TRIGGERS PARA CAMBIOS DE VALORES DE LA COLUMNA ESTADO_GENERAL EN LA TABLA INVENTARIO --
-- Este trigger tiene el objetivo de actualizar el estado de disponibilidad o no de un equipo médico.
-- Usualmente, cuando se inicia un correctivo, el dispositivo sale del servicio médico y queda no disponible,
-- por lo que se plantea la necesidad de que este estado de indisponibilidad se vea en el inventario, tanto cuando el equipo
-- sale del servicio, como cuando vuelve a estar operativo.

DELIMITER //
CREATE TRIGGER estado_general_indisponible
AFTER INSERT ON correctivos
FOR EACH ROW
BEGIN
	IF NEW.Fecha_Fin_Correctivo IS NULL THEN
		UPDATE inventario SET Estado_General = "EN MANTENIMIENTO"
		WHERE Id_Inventario = NEW.Id_Inventario;
    ELSE 
		UPDATE inventario SET Estado_General = "OPERATIVO"
		WHERE Id_Inventario = NEW.Id_Inventario;
    
    END IF;
END;
//

DELIMITER //
CREATE TRIGGER estado_general_disponible
AFTER UPDATE ON correctivos
FOR EACH ROW
BEGIN
	IF NEW.Fecha_Fin_Correctivo IS NULL THEN
		UPDATE inventario SET Estado_General = "EN MANTENIMIENTO"
		WHERE Id_Inventario = NEW.Id_Inventario;
    ELSE 
		UPDATE inventario SET Estado_General = "OPERATIVO"
		WHERE Id_Inventario = NEW.Id_Inventario;
    
    END IF;
END;
//

-- TRIGGERS PARA CARGAR DE DATOS EN TABLA AUDITORIA --
-- ESTOS TRIGGERS SIRVEN PARA LLEVAR UN HISTORIAL DE LOS CAMBIOS QUE SE REALIZAN EN LA TABLA INVENTARIO.

DELIMITER //
CREATE TRIGGER Alta_Inventario
AFTER INSERT ON inventario
FOR EACH ROW
BEGIN
    INSERT INTO inventario_auditoria(Id_Inventario, Acción, Usuario)
    VALUES (New.Id_Inventario, "INSERT", USER());
END;
//
DELIMITER ;

CALL Alta_Equipos("CSI-34870-200", "Cama_Internación", 6, "SV2 Plus", 55555, "Cama de Internación", 2, 19, 1, "2025-6-6", 0, 3900, 66666, "Propio", 34870, "Operativo");


DELIMITER //
CREATE TRIGGER Update_Inventario
AFTER UPDATE ON inventario
FOR EACH ROW
BEGIN
    INSERT INTO inventario_auditoria(Id_Inventario, Acción, Usuario)
    VALUES (New.Id_Inventario, "UPDATE", USER());
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Delete_Inventario
BEFORE DELETE ON inventario
FOR EACH ROW
BEGIN
    INSERT INTO inventario_auditoria(Id_Inventario, Acción, Usuario)
    VALUES (OLD.Id_Inventario, "DELETE", USER());
END;
//
DELIMITER ;

/* SE PLANTEAN CREAR LOS SIGUIENTES USUARIO:
ADMIN: puede manejar toda la base de datos.
SUPERVISOR: puede insertar en la tabla inventario y realizar cualquier modificación en las demas tablas de la BD
TECNICO1 y TECNICO2: pueden insertar en las tablas correctivos y preventivos y actualizarlas
*/

-- CREACION DE USUARIOS --
USE equipamientomedico_proyectofinal;

CREATE USER "ADMIN"@"localhost" IDENTIFIED BY "admin";
CREATE USER "SUPERVISOR"@"localhost" IDENTIFIED BY "super";
CREATE USER "TECNICO1"@"localhost" IDENTIFIED BY "1234";
CREATE USER "TECNICO2"@"localhost" IDENTIFIED BY "4321";

-- ASIGNACION DE PERMISOS -- 

GRANT ALL PRIVILEGES ON equipamientomedico_proyectofinal.* TO "ADMIN"@"localhost";

GRANT ALL PRIVILEGES ON equipamientomedico_proyectofinal.correctivos TO "SUPERVISOR"@"localhost";
GRANT ALL PRIVILEGES ON equipamientomedico_proyectofinal.preventivos TO "SUPERVISOR"@"localhost";
GRANT ALL PRIVILEGES ON equipamientomedico_proyectofinal.marca TO "SUPERVISOR"@"localhost";
GRANT ALL PRIVILEGES ON equipamientomedico_proyectofinal.proveedor TO "SUPERVISOR"@"localhost";
GRANT ALL PRIVILEGES ON equipamientomedico_proyectofinal.servicios TO "SUPERVISOR"@"localhost";
GRANT ALL PRIVILEGES ON equipamientomedico_proyectofinal.fallas TO "SUPERVISOR"@"localhost";
GRANT SELECT, INSERT, UPDATE ON equipamientomedico_proyectofinal.inventario TO "SUPERVISOR"@"localhost";

GRANT SELECT, INSERT, UPDATE ON equipamientomedico_proyectofinal.correctivos TO "TECNICO1"@"localhost";
GRANT SELECT, INSERT, UPDATE ON equipamientomedico_proyectofinal.preventivos TO "TECNICO1"@"localhost";
GRANT SELECT ON equipamientomedico_proyectofinal.inventario TO "TECNICO1"@"localhost";

GRANT SELECT, INSERT, UPDATE ON equipamientomedico_proyectofinal.correctivos TO "TECNICO2"@"localhost";
GRANT SELECT, INSERT, UPDATE ON equipamientomedico_proyectofinal.preventivos TO "TECNICO2"@"localhost";
GRANT SELECT ON equipamientomedico_proyectofinal.inventario TO "TECNICO2"@"localhost";

-- VISUALIZACION DE PERMISOS --
SHOW GRANTS FOR "ADMIN"@"localhost";
SHOW GRANTS FOR "SUPERVISOR"@"localhost";
SHOW GRANTS FOR "TECNICO1"@"localhost";
SHOW GRANTS FOR "TECNICO2"@"localhost";