USE MASTER
IF DB_ID('DBCEDAR') IS NOT NULL
	DROP DATABASE DBCEDAR
GO
USE master
CREATE DATABASE DBCEDAR
GO
USE DBCEDAR
GO
SP_HELPDB DBCEDAR --Visualizar la existencia de la base de datos
GO

CREATE TABLE Origen(

	OrigenID INT PRIMARY KEY,
    NombreOrigen varchar(120) UNIQUE,
    DireccionOrigen varchar(200)
)
GO

CREATE TABLE Destino(
	DestinoID INT PRIMARY KEY,
	NombreDestino VARCHAR(120) UNIQUE,
	DireccionDestino VARCHAR(120) UNIQUE
)

create table CargoEmpleado(
	CargoID int primary key ,
    NombreCargo varchar(200) unique,
    DescripcionCargo varchar(700)
);

create table Estado(
	id_estado int primary key ,
    nombre_estado varchar(30)
);


create table tipo_entrega(
	id_entrega int primary key auto_increment,
    tipo_entrega varchar(100)
); 

create table forma_pago(
	id_forma_pago int primary key auto_increment,
    forma_pago varchar(100)
);

create table garantia(
	id_garantia int primary key auto_increment,
    garantia varchar(100)
);

create table Empleado(
	EmpleadoID varchar(8) primary key,
    NombreEmpleado varchar(120),
    ApellidoEmpleado varchar(120),
    EmailEmpleado varchar(200),
    TelefonoEmpleado varchar(9),
    
    id_cargo_fk int, foreign key (id_rol_fk) references CargoEmpleado(CargoID),
    id_estado_fk int, foreign key (id_estado_fk) references estado(id_estado),
    id_lugar_fk int, foreign key (id_lugar_fk) references lugar(id_lugar)
);

create table caracteristica(
	id_caracteristica int primary key auto_increment,
    caracteristica varchar(30)
);

create table estadoEncomienda(
	id_estado int primary key auto_increment,
    nombre_estado varchar(30)
);


CREATE TABLE tipo_remitente (
    id_tipo_remitente int primary key auto_increment,
    nombre_tipo varchar(50)
);

CREATE TABLE tipo_destinatario (
    id_tipo_destinatario int primary key auto_increment,
    nombre_tipo varchar(50)
);


create table remitente(
	id_remitente varchar(11) primary key,
    nombre_remitente varchar(200),
    apellido_pat_remitente varchar(200),
    apellido_mat_remitente varchar(200),
    correo_remitente varchar(350),
    telefono_remitente varchar(9),
    
    id_estado_fk int, foreign key (id_estado_fk) references estado(id_estado),
    id_lugar_fk int, foreign key (id_lugar_fk) references lugar(id_lugar)
);


create table destinatario(
	id_destinatario varchar(11) primary key,
    nombre_destinatario varchar(200),
    apellido_pat_destinatario varchar(200),
    apellido_mat_destinatario varchar(200),
    correo_destinatario varchar(350),
    telefono_destinatario varchar(9),
    direccion_destinatario varchar(900),
    
    id_estado_fk int, foreign key (id_estado_fk) references estado(id_estado),
    id_lugar_fk int, foreign key (id_lugar_fk) references lugar(id_lugar)
);

create table encomienda(
	id_encomienda varchar(20) primary key,
    peso_encomienda decimal(10,2),
    altura_encomienda decimal(10,2),
    ancho_encomienda decimal(10,2),
    largo_encomienda decimal(10,2),
	
    id_estado_fk int, foreign key (id_estado_fk) references estadoEncomienda(id_estado),
    id_garantia_fk int, foreign key (id_garantia_fk) references garantia(id_garantia),
    id_caracteristica_fk int, foreign key (id_caracteristica_fk) references caracteristica(id_caracteristica)
    
    -- REMITENTE
    -- DESTINATARIO
);

CREATE TABLE relacion_encomienda (
    id_relacion int primary key auto_increment,
    id_encomienda varchar(20),
    id_remitente varchar(11),
    id_destinatario varchar(11),
    id_tipo_remitente int,
    id_tipo_destinatario int,
    FOREIGN KEY (id_encomienda) REFERENCES encomienda(id_encomienda),
    FOREIGN KEY (id_remitente) REFERENCES remitente(id_remitente),
    FOREIGN KEY (id_destinatario) REFERENCES destinatario(id_destinatario),
    FOREIGN KEY (id_tipo_remitente) REFERENCES tipo_remitente(id_tipo_remitente),
    FOREIGN KEY (id_tipo_destinatario) REFERENCES tipo_destinatario(id_tipo_destinatario)
);

create table boletaFactura(
	id_boleta int primary key auto_increment,
    pdf_boleta longblob,
    id_remintente_fk varchar(8), foreign key (id_remintente_fk) references remitente(id_remitente)
);

show tables;