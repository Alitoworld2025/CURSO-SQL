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
("Hogner");


CREATE TABLE Proveedor (
Id_Proveedor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Nombre_Proveedor VARCHAR(100)
);

CREATE TABLE Categoria (
Id_Categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Nombre_Categoria VARCHAR(100)
);

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
("Stryker");

INSERT INTO Categoria (Nombre_Categoria) VALUES
("Terapéutico"), ("Diagnóstico"), ("Analítico"), ("Varios");


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
Valor_Funcion_Clinica INT,
Valor_Riesgo_Asociado INT,
Valor_Requerimiento_Mantenimiento INT,
Indice_Mantenimiento INT,
Frecuencia_Mantenimiento_Preventivo_meses INT,
Costo FLOAT,
Orden_de_Compra INT,
Estado_Contractual VARCHAR(100)
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
FOREIGN KEY (Id_Tipo_Falla) REFERENCES Fallas(Id_Tipo_Falla),
Descripcion_Falla MEDIUMTEXT,
Resolucion_Falla MEDIUMTEXT
);

CREATE TABLE Preventivos (
Id_Preventivo INT PRIMARY KEY AUTO_INCREMENT,
Id_Inventario VARCHAR(100),
FOREIGN KEY (Id_Inventario) REFERENCES Inventario(Id_Inventario),
Fecha_Inicio_Preventivo DATETIME,
Fecha_Fin_Preventivo DATETIME,
Observaciones MEDIUMTEXT
);

INSERT INTO Inventario (Id_Inventario, Nombre_Equipo, Id_Marca, Modelo, Serie, Descripcion, Id_Servicio, Id_Proveedor, 
Id_Categoria, Fecha_Instalacion, Valor_Funcion_Clinica, Valor_Riesgo_Asociado, Valor_Requerimiento_Mantenimiento, 
Indice_Mantenimiento, Frecuencia_Mantenimiento_Preventivo_meses, Costo, Orden_de_Compra,Estado_Contractual)
VALUES ("DESFI_CN32617961", "Desfibrilador", 4, "DFM100", "CN32617961", "Desfibrilador Bifasico", 4, 2, 1, "2019-06-11",
10, 5, 3, 18, 6, 11000, 4589, "Propio"),
("MON_MULTI_6006230475", "Monitor_Multiparamétrico", 2, "Infinity Delta", "6006230475", "Monitor Multiparamétrico de Cabecera",4, 3, 2, "2013-01-05", 7, 3, 2, 12, 12, 3500, 38567, "Propio"),
("MON_MULTI_6009433170", "Monitor_Multiparamétrico", 2, "Infinity Delta XL", 6009433170, "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6005580473", "Monitor_Multiparamétrico", 2, "Infinity Delta", "6005580473", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2014-01-04", 7, 3, 2, 12, 12, 3500, 38997, "Propio"),
("MON_MULTI_6001518674", "Monitor_Multiparamétrico", 2, "Infinity Vista XL", "6001518674", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6004936662", "Monitor_Multiparamétrico", 2, "Infinity Vista XL", "6004936662", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_AC6-2A033353", "Monitor_Multiparamétrico", 1, "ePM12", "AC6-2A033353", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC6-2A033690", "Monitor_Multiparamétrico", 1,"ePM12", "AC6-2A033690", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC6-2A033692", "Monitor_Multiparamétrico", 1,"ePM12", "AC6-2A033692", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC6-2A033349", "Monitor_Multiparamétrico", 1, "ePM12", "AC6-2A033349", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC6-2A033344", "Monitor_Multiparamétrico", 1, "ePM12", "AC6-2A033344", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC6-2A033695", "Monitor_Multiparamétrico", 1, "ePM12", "AC6-2A033695", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031639", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031639", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031643", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031643", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031642", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031642", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031647", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031647", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031641", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031641", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031638", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031638", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031644", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031644", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031650", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031650", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031640", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031640", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_AC9-23031646", "Monitor_Multiparamétrico", 1, "ePM12", "AC9-23031646", "Monitor Multiparamétrico de Cabecera", 4, 1, 2, "2023-10-10", 7, 3, 2, 12, 12, 3800, 42997, "Propio"),
("MON_MULTI_6001251567", "Monitor_Multiparamétrico", 2, "Infinity Vista XL", "6001251567", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6001471777", "Monitor_Multiparamétrico", 2, "Infinity Vista XL", "6001471777", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6005579466", "Monitor_Multiparamétrico", 2, "Infinity Delta", "6005579466", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2014-03-01", 7, 3, 2, 12, 12, 3500, 38997, "Propio"),
("MON_MULTI_6002737961", "Monitor_Multiparamétrico", 2, "Infinity Vista XL", "6002737961", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6006176578", "Monitor_Multiparamétrico", 2, "Infinity Delta", "6006176578", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2014-01-03", 7, 3, 2, 12, 12, 3500, 38997, "Propio"),
("MON_MULTI_6002679286", "Monitor_Multiparamétrico", 2, "Infinity Delta", "6002679286", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6009432670", "Monitor_Multiparamétrico", 2, "Infinity Delta XL", "6009432670", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6002744071", "Monitor_Multiparamétrico", 2, "Infinity Vista XL", "6002744071", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2019-12-01", 7, 3, 2, 12, 12, 3500, 40115, "Propio"),
("MON_MULTI_6005578369", "Monitor_Multiparamétrico", 2, "Infinity Delta", "6005578369", "Monitor Multiparamétrico de Cabecera", 4, 3, 2, "2014-03-01", 7, 3, 2, 12, 12, 3500, 38997, "Propio"),
("MON_MULTI_KQ-81008995", "Monitor_Multiparamétrico", 1, "uMec 12", "KQ-81008995", "Monitor Multiparamétrico de Transporte", 4, 1, 2, "2017-08-15", 7, 3, 2, 12, 12, 1600, 39123, "Propio"),
("MON_MULTI_EX9C076112", "Monitor_Multiparamétrico", 1, "iMEC10", "EX9C076112", "Monitor Multiparamétrico de Transporte", 4, 1, 2, "2017-08-15", 7, 3, 2, 12, 12, 1900, 39123, "Propio"),
("MON_MULTI_EX9C076113", "Monitor_Multiparamétrico", 1, "iMEC10", "EX9C076113", "Monitor Multiparamétrico de Transporte", 4, 1, 2, "2018-03-19", 7, 3, 2, 12, 12, 1900, 41433, "Propio"),
("CAMA_4967100008870084", "Cama_Internación", 6, "SV1", "4967100008870084", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_4967100008870080", "Cama_Internación", 6, "SV1", "4967100008870080", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900098", "Cama_Internación", 6, "SV1", "5741100014900098", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900113", "Cama_Internación", 6, "SV1", "5741100014900113", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900120", "Cama_Internación", 6, "SV1", "5741100014900120", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900145", "Cama_Internación", 6, "SV1", "5741100014900145", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900161", "Cama_Internación", 6, "SV1", "5741100014900161", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900162", "Cama_Internación", 6, "SV1", "5741100014900162", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900166", "Cama_Internación", 6, "SV1", "5741100014900166", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900168", "Cama_Internación", 6, "SV1", "5741100014900168", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900175", "Cama_Internación", 6, "SV1", "5741100014900175", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-03-19", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_5741100014900176", "Cama_Internación", 6, "SV1", "5741100014900176", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2017-08-15", 8, 1, 2, 11, 0, 3790, 43876, "Propio"),
("CAMA_5741100014900177", "Cama_Internación", 6, "SV1", "5741100014900177", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2017-08-15", 8, 1, 2, 11, 0, 3790, 43876, "Propio"),
("CAMA_5741100014900179", "Cama_Internación", 6, "SV1", "5741100014900179", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2017-08-15", 8, 1, 2, 11, 0, 3790, 43876, "Propio"),
("CAMA_4967100008870066", "Cama_Internación", 6, "SV1", "4967100008870066", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_4967100008870077", "Cama_Internación", 6, "SV1", "4967100008870077", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_4967100008870079", "Cama_Internación", 6, "SV1", "4967100008870079", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_0680100015500082", "Cama_Internación", 6, "SV2 Plus", "0680100015500082", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2017-08-15", 8, 1, 2, 11, 0, 3790, 43876, "Propio"),
("CAMA_0680100015500083", "Cama_Internación", 6, "SV2 Plus", "0680100015500083", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_0680100015500085", "Cama_Internación", 6, "SV2 Plus", "0680100015500085", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_4967100008870071", "Cama_Internación", 6, "SV1", "4967100008870071", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_0680100015500090", "Cama_Internación", 6, "SV2 Plus", "0680100015500090", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_0680100015500091", "Cama_Internación", 6, "SV2 Plus", "0680100015500091", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_0680100015500093", "Cama_Internación", 6, "SV2 Plus", "0680100015500093", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2017-08-15", 8, 1, 2, 11, 0, 3790, 43876, "Propio"),
("CAMA_0680100015500095", "Cama_Internación", 6, "SV2 Plus", "0680100015500095", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2017-08-15", 8, 1, 2, 11, 0, 3790, 43876, "Propio"),
("CAMA_0680100015500098", "Cama_Internación", 6, "SV2 Plus", "0680100015500098", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2017-08-15", 8, 1, 2, 11, 0, 3790, 43876, "Propio"),
("CAMA_4967100008870074", "Cama_Internación", 6, "SV1", "4967100008870074", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_4967100008870075", "Cama_Internación", 6, "SV1", "4967100008870075", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("CAMA_4967100008870081", "Cama_Internación", 6, "SV1", "4967100008870081", "Cama de Internación electrohidraulica con control remoto", 4, 19, 1, "2018-10-01", 8, 1, 2, 11, 0, 3790, 47311, "Propio"),
("RESPI_ASFA-0030", "Respirador", 2, "V300", "ASFA-0030", "Respirador Mecánico para Ventilación Invasiva", 4, 3, 1, "2014-06-09", 10, 5, 3, 18, 12, 12000, 21467, "Propio"),
("RESPI_ASFA-0031", "Respirador", 2, "V300", "ASFA-0031", "Respirador Mecánico para Ventilación Invasiva", 4, 3, 1, "2014-06-09", 10, 5, 3, 18, 12, 12000, 21467, "Propio"),
("RESPI_ASFA-0032", "Respirador", 2, "V300", "ASFA-0032", "Respirador Mecánico para Ventilación Invasiva", 4, 3, 1, "2014-06-09", 10, 5, 3, 18, 12, 12000, 21467, "Propio"),
("RESPI_ASFE-0003", "Respirador", 2, "V300", "ASFE-0003", "Respirador Mecánico para Ventilación Invasiva", 4, 3, 1, "2014-07-31", 10, 5, 3, 18, 12, 12000, 21489, "Propio"),
("RESPI_ASFE-0004", "Respirador", 2, "V300", "ASFE-0004", "Respirador Mecánico para Ventilación Invasiva", 4, 3, 1, "2014-07-31", 10, 5, 3, 18, 12, 12000, 21489, "Propio"),
("RESPI_22708", "Respirador", 15, "Servo U", "22708", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2016-07-24", 10, 5, 3, 18, 12, 13700, 21966, "Propio"),
("RESPI_22709", "Respirador", 15, "Servo U", "22709", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2016-07-24", 10, 5, 3, 18, 12, 13700, 21966, "Propio"),
("RESPI_12735", "Respirador", 15, "Servo Air", "12735", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2018-06-01", 10, 5, 3, 18, 12, 13700, 22221, "Propio"),
("RESPI_12728", "Respirador", 15, "Servo Air", "12728", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2018-11-05", 10, 5, 3, 18, 12, 13700, 22634, "Propio"),
("RESPI_85073", "Respirador", 15, "Servo I", "85073", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2018-11-05", 10, 5, 3, 18, 12, 13700, 22634, "Propio"),
("RESPI_85074", "Respirador", 15, "Servo I", "85074", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2018-11-05", 10, 5, 3, 18, 12, 13700, 22634, "Propio"),
("RESPI_TV01706090F", "Respirador", 4, "Trilogy 202", "TV01706090F", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2017-10-11", 10, 5, 3, 18, 12, 10800, 22066, "Propio"),
("RESPI_ASBF- 0063", "Respirador", 2, "Evita 4", "ASBF- 0063", "Respirador Mecánico para Ventilación Invasiva", 4, 3, 1, "2010-01-01", 10, 5, 3, 18, 12, 11900, 19234, "Propio"),
("RESPI_21809", "Respirador", 15, "Servo Air", "21809", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2021-07-02", 10, 5, 3, 18, 12, 13700, 23117, "Propio"),
("RESPI_21813", "Respirador", 15, "Servo Air", "21813", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2021-07-02", 10, 5, 3, 18, 12, 13700, 23117, "Propio"),
("RESPI_21814", "Respirador", 15, "Servo Air", "21814", "Respirador Mecánico para Ventilación Invasiva", 4, 2, 1, "2021-07-02", 10, 5, 3, 18, 12, 13700, 23117, "Propio"),
("RESPI_GB-86006161", "Respirador", 1, "SV300", "GB-86006161", "Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo", 4, 1, 1, "2018-12-19", 10, 5, 3, 18, 12, 13000, 49876, "Propio"),
("RESPI_GB-86006158", "Respirador", 1, "SV300", "GB-86006158", "Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo", 4, 1, 1, "2018-12-19", 10, 5, 3, 18, 12, 13000, 49876, "Propio"),
("RESPI_GB-86006167", "Respirador", 1, "SV300", "GB-86006167", "Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo", 4, 1, 1, "2018-12-19", 10, 5, 3, 18, 12, 13000, 49876, "Propio"),
("RESPI_GB-86006168", "Respirador", 1, "SV300", "GB-86006168", "Respirador Mecánico para Ventilación Invasiva, VNI y Alto Flujo", 4, 1, 1, "2019-08-16", 10, 5, 3, 18, 12, 13000, 49876, "Propio"),
("RESPI_ASDF-0031", "Respirador", 2, "Carina", "ASDF-0031", "Respirador de Transporte", 4, 3, 1, "2014-06-09", 10, 5, 3, 18, 12, 9800, 21467, "Propio"),
("RESPI_ASCK-0017", "Respirador", 2, "Carina", "ASCK-0017", "Respirador de Transporte", 4, 3, 1, "2014-06-09", 10, 5, 3, 18, 12, 9800, 21467, "Propio"),
("DESFI_ CN32617767", "Desfibrilador", 4, "DFM100", "CN32617767", "Desfibrilador Bifasico", 4, 2, 1, "2020-03-10", 10, 5, 3, 18, 6, 11000, 4589, "Propio"),
("DESFI_CN32617971", "Desfibrilador", 4, "DFM100", "CN32617971", "Desfibrilador Bifasico", 4, 2, 1, "2019-06-11", 10, 5, 3, 18, 6, 11000, 4589, "Propio"),
("DESFI_CN32617967", "Desfibrilador", 4, "DFM100", "CN32617967", "Desfibrilador Bifasico", 4, 2, 1, "2019-06-11", 10, 5, 3, 18, 6, 11000, 4589, "Propio");

