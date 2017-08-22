CREATE DATABASE NodosCognitivos;
USE NodosCognitivos;

--Modulo / paquetes de los Casos de Uso
CREATE TABLE modulo
(
id int Primary key,
nombre varchar(20) not null
);


-- Casos de Uso
CREATE TABLE casodeuso
(
id int Primary key,
nombre varchar(20) not null,
posicion varchar(10),
idModulo int not null,
Foreign key(idModulo) references modulo(id)
);

-- Detalle Caso de Uso con Cargos
CREATE TABLE detalle_casoUso
(
idDeta int not null,
idCu int not null,
primary key(idCu,idDeta),
idCargo int not null,
foreign key(idCu) references casodeuso(id),
foreign key(idCargo) references cargo(id)
);

--cargos / privilegios
CREATE TABLE cargo
(
id int Primary key,
nombre varchar(20) not null
);

--bitacora del administrativo
CREATE TABLE bitacora
(
id int Primary key,
inicio date not null,
fin date not null,
cargo int not null
);

-- detalle bitacora
CREATE TABLE detalle_bitacora
(
idBit int not null,
idDetalle int not null,
Primary key(idBit,idDetalle),
accion varchar(50) not null,
hora datetime not null,
tabla varchar(50) not null,
Foreign key(idBit) references bitacora(id)
on update cascade
on delete cascade
);

--usuario principal
CREATE TABLE persona
(
id int Primary key,
pass varchar(10) not null,
nombre varchar(50) not null,
nick varchar(15) not null,
estado bit default 1,
idCargo int not null,
Foreign key(idCargo) references cargo(id),
idBit int not null,
Foreign key(idBit) references bitacora(id)

);

--cursos creados
CREATE TABLE curso
(
id int Primary key,
nombre varchar(50) not null,
descripcion varchar(150) not null,
concluido bit default 0,
idPersona int not null,
Foreign key(idPersona) references persona(id)
);

--Nodo principal
CREATE TABLE nodo
(
id int Primary key,
titulo varchar(50) not null,
aprobado bit default 0,
habilitado bit default 0,
idCurso int not null,
Foreign key(idCurso) references curso(id)
on update cascade
on delete cascade
);

---Prerequisito de Nodo
CREATE TABLE prereq
(
idNodo int not null,
idPre int not null,
Primary key(idNodo,idPre)
);

alter table prereq
add Foreign key(idNodo) references nodo(id)
on update no action on delete no action;
alter table prereq
add foreign key (idPre) references nodo(id)
on update no action on delete no action;


--Subnodos dentro del nodo principal
CREATE TABLE subnodo
(
id int Primary key,
idNodo int not null,
titulo varchar(50) not null,
contenido varchar(max) not null,
aprobado bit default 0,
habilitado bit default 0,
puntaje int ,
Foreign key(idNodo) references nodo(id)
on update cascade
on delete cascade
);


-- Respuesta de la Pregunta
CREATE TABLE respuesta
(
idResp int not null,
idPre int not null,
Primary key(idPre, idResp),
descripcion varchar(20) not null,
aprobado bit default 0,
comentario varchar(15) not null,
idSubnodo int not null,
Foreign key(idPre) references pregunta(id)
on update cascade 
on delete cascade, 
Foreign key(idSubnodo) references subnodo(id)
on update no action
on delete no action

);

--REtroalimentacion del nodo
CREATE TABLE pregunta
(
id int Primary key,
descripcion varchar(20) not null,
idTipo int not null,
idSubnodo int not null,
Foreign key(idTipo) references tipopregunta(id)
on update cascade
on delete cascade,
Foreign key(idSubnodo) references subnodo(id)
on update cascade
on delete cascade
);

---Tipo de Pregunta (seleccion multiple, escribir, etc)
CREATE TABLE tipopregunta
(
id int Primary key,
nombre varchar(15) not null
);


--------------Inserciones -----------------



