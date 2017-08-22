

CREATE DATABASE NodosCognitivos;

USE NodosCognitivos;
--//////////////////////////////////////////////////////////
--MODULO / PAQUETES DE LOS CASOS DE USO
--//////////////////////////////////////////////////////////

CREATE TABLE MODULO
(
ID INT PRIMARY KEY,
NOMBRE VARCHAR(20) NOT NULL
);

--//////////////////////////////////////////////////////////
-- CASOS DE USO
--//////////////////////////////////////////////////////////

CREATE TABLE CU
(
ID INT PRIMARY KEY,
NOMBRE VARCHAR(20) NOT NULL,
POSICION VARCHAR(10),
ID_MODULO INT NOT NULL,
FOREIGN KEY(ID_MODULO) REFERENCES MODULO(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
--CARGOS / PRIVILEGIOS
--//////////////////////////////////////////////////////////

CREATE TABLE CARGO
(
ID INT PRIMARY KEY,
NOMBRE VARCHAR(20) NOT NULL,
DESCRIPCION VARCHAR(100) NOT NULL
);

--//////////////////////////////////////////////////////////
-- DETALLE CASO DE USO CON CARGOS
--//////////////////////////////////////////////////////////

CREATE TABLE DETALLE_CU
(
ID INT NOT NULL,
ID_CU INT NOT NULL,
PRIMARY KEY(ID_CU,ID),
IDCARGO INT NOT NULL,
HABILITADO BIT DEFAULT 1,
FOREIGN KEY(ID_CU) REFERENCES CU(ID),
FOREIGN KEY(IDCARGO) REFERENCES CARGO(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
--USUARIO PRINCIPAL
--//////////////////////////////////////////////////////////

CREATE TABLE PERSONA
(
ID INT PRIMARY KEY,
PASS VARCHAR(10) NOT NULL,
NOMBRE VARCHAR(50) NOT NULL,
NICK VARCHAR(15) NOT NULL,
EMAIL VARCHAR(50) NOT NULL,
ESTADO BIT DEFAULT 1,
IDCARGO INT NOT NULL,
ESTADO BIT DEFAULT 1,
FOREIGN KEY(IDCARGO) REFERENCES CARGO(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
--BITACORA DEL ADMINISTRATIVO
--//////////////////////////////////////////////////////////

CREATE TABLE BITACORA
(
ID INT PRIMARY KEY,
INICIO DATETIME NOT NULL,
FIN DATETIME NOT NULL,
ID_PERSONA INT NOT NULL,
FOREIGN KEY(ID_PERSONA) REFERENCES PERSONA(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
-- DETALLE BITACORA
--//////////////////////////////////////////////////////////

CREATE TABLE DETALLE_BITACORA
(
ID INT NOT NULL,
ID_BITACORA INT NOT NULL,
ACCION VARCHAR(50) NOT NULL,
HORA DATETIME NOT NULL,
TABLA VARCHAR(50) NOT NULL,
PRIMARY KEY(ID_BITACORA,ID),
FOREIGN KEY(ID_BITACORA) REFERENCES BITACORA(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
--CURSOS CREADOS
--//////////////////////////////////////////////////////////

CREATE TABLE CURSO
(
ID INT PRIMARY KEY,
NOMBRE VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(150) NOT NULL,
CONCLUIDO BIT DEFAULT 0,
PUNTAJE INT NOT NULL,
ID_PERSONA INT NOT NULL,
ESTADO BIT DEFAULT 1,
FOREIGN KEY(ID_PERSONA) REFERENCES PERSONA(ID)
);

--//////////////////////////////////////////////////////////
--NODO PRINCIPAL
--//////////////////////////////////////////////////////////

CREATE TABLE NODO
(
ID INT PRIMARY KEY,
TITULO VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(255) NOT NULL,
APROBADO BIT DEFAULT 0,
HABILITADO BIT DEFAULT 0,
ID_CURSO INT NOT NULL,
ESTADO BIT DEFAULT 1,
FOREIGN KEY(ID_CURSO) REFERENCES CURSO(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
---PREREQUISITO DE NODO
--//////////////////////////////////////////////////////////

CREATE TABLE PRE
(
ID_NODO INT NOT NULL,
ID_PRE INT NOT NULL,
PRIMARY KEY(ID_PRE,ID_NODO)
);
ALTER TABLE PRE
ADD FOREIGN KEY(ID_NODO) REFERENCES NODO(ID)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE PRE
ADD FOREIGN KEY (ID_PRE) REFERENCES NODO(ID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

--//////////////////////////////////////////////////////////
--SUBNODOS DENTRO DEL NODO PRINCIPAL
--//////////////////////////////////////////////////////////

CREATE TABLE SUBNODO
(
ID INT PRIMARY KEY,
ID_NODO INT NOT NULL,
TITULO VARCHAR(50) NOT NULL,
CONTENIDO VARCHAR(MAX) NOT NULL,
APROBADO BIT DEFAULT 0,
HABILITADO BIT DEFAULT 0,
PUNTAJE INT,
ESTADO BIT DEFAULT 1,
FOREIGN KEY(ID_NODO) REFERENCES NODO(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
---TIPO DE PREGUNTA (SELECCION MULTIPLE, ESCRIBIR, ETC)
--//////////////////////////////////////////////////////////

CREATE TABLE TIPO_PREGUNTA
(
ID INT PRIMARY KEY,
NOMBRE VARCHAR(15) NOT NULL
);

--//////////////////////////////////////////////////////////
--RETROALIMENTACION DEL NODO
--//////////////////////////////////////////////////////////

CREATE TABLE PREGUNTA
(
ID INT PRIMARY KEY,
DESCRIPCION VARCHAR(20) NOT NULL,
PUNTAJE INT NOT NULL,
ID_TIPO INT NOT NULL,
ID_SUBNODO INT NOT NULL,
ESTADO BIT DEFAULT 1,
FOREIGN KEY(ID_TIPO) REFERENCES TIPO_PREGUNTA(ID)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY(ID_SUBNODO) REFERENCES SUBNODO(ID)
ON UPDATE CASCADE
ON DELETE CASCADE
);

--//////////////////////////////////////////////////////////
-- RESPUESTA DE LA PREGUNTA
--//////////////////////////////////////////////////////////

CREATE TABLE RESPUESTA
(
ID INT NOT NULL,
ID_PREGUNTA INT NOT NULL,
PRIMARY KEY(ID_PREGUNTA, ID),
DESCRIPCION VARCHAR(20) NOT NULL,
APROBADO BIT DEFAULT 0,
COMENTARIO VARCHAR(15) NOT NULL,
ID_SUBNODO INT NOT NULL,
ESTADO BIT DEFAULT 1,
FOREIGN KEY(ID_PREGUNTA) REFERENCES PREGUNTA(ID)
ON UPDATE CASCADE 
ON DELETE CASCADE, 
FOREIGN KEY(ID_SUBNODO) REFERENCES SUBNODO(ID)
ON UPDATE NO ACTION
ON DELETE NO ACTION
);
--//////////////////////////////////////////////////////////




--------------INSERCIONES -----------------




