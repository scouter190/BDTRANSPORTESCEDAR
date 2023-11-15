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

create table TBRemitente(
	RemitenteID varchar(25) PRIMARY KEY,
    RemitenteNombre varchar(200),
    RemitenteApellidos varchar(200),
    RemitenteCorreo varchar(350),
    RemitenteTelefono varchar(9),
    EstadoID_FK int ,
	OrigenID_FK INT,
    FOREIGN KEY (EstadoID_FK) references TBEstadoEnvio(EstadoID),
    FOREIGN KEY (OrigenID_FK) references TBOrigen(OrigenID) --direccion agencia
)
GO

CREATE TABLE TBCliente(
	IDCLiente int primary key, --NroIdentificacion en base a DocIdentidad (dni o ruc)//Solo bastaria con la
	ClienteNombre varchar(30),	--Tabla Cliente para referenciar tanto emisor como destinatario.
	ClienteApellido varchar(50),
)
GO

CREATE TABLE TBEstadoEnvio(
	EstadoID int primary key ,
    EstadoDescripcion varchar(30)
)
GO

CREATE TABLE TBOrigen(
	OrigenID INT PRIMARY KEY IDENTITY(1,1),
    OrigenNombre varchar(120) UNIQUE,
    OrigenDireccion varchar(200)
)
GO

CREATE TABLE TBDestino(
	DestinoID INT PRIMARY KEY,
	DestinoNombre VARCHAR(120) UNIQUE,
	DestinoDireccion VARCHAR(120) UNIQUE
)
GO




CREATE TABLE TBDestinatario(
	DestinatarioID varchar(11) primary key, -- pero como introduzco este id y como lo identifico
    DestinatarioNombres varchar(200),		--si no todos son con DNI ????
    DestinatarioApellidos varchar(200),
    correo_destinatario varchar(350),
    telefono_destinatario varchar(9),
    direccion_destinatario varchar(900),
    
    id_estado_fk int, foreign key (id_estado_fk) references estado(id_estado),
    id_lugar_fk int, foreign key (id_lugar_fk) references lugar(id_lugar)
)
GO

CREATE TABLE TBEncomiendaGarantia(  -- Es necesario colocar tabla garantia?
	GaratiaID int primary key,
    garantia varchar(100)
)

create table TBCargoEmpleado(					
	CargoID int primary key ,
    CargoNombres varchar(200) unique,
    CargoDescripcion varchar(700)
)
GO

--Es necesario crear la tabla estado?
--Donde cada estado tiene su id 
		-- tipo : ID 1 DESCP RECEPCIONADO
		--		: ID 2 DESCP EN RUTA 
		--		: ID 3 DESCP ENTREGADO

CREATE TABLE TBTipoEntrega(
	id_entrega int primary key ,    -- ID O     
    tipo_entrega varchar(100)		-- CONTRAENTREGA
)
GO

create table forma_pago(
	id_forma_pago int primary key ,
    forma_pago varchar(100)
)
GO

create table Empleado(
	EmpleadoID varchar(8) primary key,
    NombreEmpleado varchar(120),
    ApellidoEmpleado varchar(120),
    EmailEmpleado varchar(200),
    TelefonoEmpleado varchar(9),
    
    id_cargo_fk int, foreign key (id_rol_fk) references CargoEmpleado(CargoID),
    id_estado_fk int, foreign key (id_estado_fk) references estado(id_estado),
    id_lugar_fk int, foreign key (id_lugar_fk) references lugar(id_lugar)
)


create table caracteristica(
	id_caracteristica int primary key ,
    caracteristica varchar(30)
)

create table encomienda(
	EncomiendaID varchar(20) primary key,
    EncomiendaPeso decimal(10,2),
    EncomiendaAltura decimal(10,2),
    EncomiendaAncho decimal(10,2),
    EncomiendaLargo decimal(10,2),
    id_estado_fk int, foreign key (id_estado_fk) references estadoEncomienda(id_estado),
    id_garantia_fk int, foreign key (id_garantia_fk) references garantia(id_garantia),
    id_caracteristica_fk int, foreign key (id_caracteristica_fk) references caracteristica(id_caracteristica)
    
    -- REMITENTE llenar con datos foraneos de la tabla remitente
    -- DESTINATARIO llenar con datos foraneos de la tabla  remtente 
)

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

CREATE TABLE relacion_encomienda (
    id_relacion int primary key ,
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