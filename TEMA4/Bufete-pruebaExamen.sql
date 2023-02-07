
/*
TIPOCASOS([idTipoCaso], desTipoCaso)
SUJETOS([idSujeto], nombre, apellidos, dni, dirPostal, email, telefono, desSujeto)
ABOGADOS([idAbogado], numColegiado, desAbogado, idSujeto*)
CLIENTELA(idCliente, estadoCivil, desCliente, idSujeto*)
CASOS([idCasos, idTipoCaso], desCasos, presupuesto, idCliente*)
llevan([idAbogado, idCasos, idTipoCaso]*, fecinicio, numdias, fecFin)
*/
CREATE DATABASE bufeteSimulacroExamen;
USE bufeteSimulacroExamen;

-- DROP DATABASE bufeteSimulacroExamen;

CREATE TABLE IF NOT EXISTS tipoCasos
(
	idTipoCaso INT(10) NOT NULL UNIQUE,
    desTipoCaso VARCHAR(50) NULL,
    
    CONSTRAINT pk_tipoCasos PRIMARY KEY(idTipoCaso)
);

CREATE TABLE IF NOT EXISTS sujetos
(
	idSujeto INT(10) NOT NULL UNIQUE,
    nombre CHAR(20) NOT NULL,
    apellidos CHAR(20) NOT NULL, 
    dni CHAR(9) NOT NULL,
    dirPostal VARCHAR(30) NOT NULL,
    email VARCHAR(30) NULL UNIQUE,
    telefono CHAR(9) NOT NULL UNIQUE,
    desSujeto VARCHAR(50) NULL,
    
    CONSTRAINT pk_sujeto PRIMARY KEY(idSujeto),
    
    CONSTRAINT email_unico UNIQUE(email)
);

CREATE TABLE IF NOT EXISTS clientela
(
	idCliente INT(10) NOT NULL UNIQUE,
    estadoCivil ENUM("S", "C", "D", "V") NULL,
    desCliente VARCHAR(100) NULL, 
    idSujeto INT(10) NULL,
    
    CONSTRAINT pk_clientela PRIMARY KEY(idCliente),
    CONSTRAINT fk_clientela_sujetos FOREIGN KEY(idSujeto)
		REFERENCES sujetos(idSujeto) -- Tiene que ser el mismo nombre que donde es PK
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS abogados
(
	idAbogado INT(10) NOT NULL UNIQUE,
    numColegiado CHAR(20) NOT NULL UNIQUE,
    desAbogado VARCHAR(100) NULL,
    idSujeto INT(10) NULL,
    
    CONSTRAINT pk_abogados PRIMARY KEY(idAbogado),
    CONSTRAINT fk_abogados_sujetos FOREIGN KEY(idSujeto)
		REFERENCES sujetos(idSujeto)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS casos
(
	idCasos INT(10) NOT NULL UNIQUE,
    idTipoCaso INT(10) NOT NULL,
    desCasos VARCHAR(100) NULL,
    presupuesto DECIMAL(7, 2) NOT NULL,
    idCliente INT(10) NULL,
    
    CONSTRAINT pk_casos_tipoCaso PRIMARY KEY(idCasos, idTipoCaso),
    CONSTRAINT fk_idTipoCaso FOREIGN KEY(idTipoCaso)
		REFERENCES tipoCasos(idTipoCaso)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_casos_clientela FOREIGN KEY(idCliente)
		REFERENCES clientela(idCliente)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS llevan
(
	idAbogado INT(10) NOT NULL,
    idCasos INT(10) NOT NULL,
    idTipoCaso INT(10) NOT NULL,
    fecinicio DATE NOT NULL,
    numdias	TINYINT,
    fecFin DATE NULL,
    
    CONSTRAINT pk_llevan PRIMARY KEY(idAbogado, idCasos, idTipoCaso),
    CONSTRAINT fk_idAbogado FOREIGN KEY(idCasos, idTipoCaso)
		REFERENCES	casos(idCasos, idTipoCaso)
		ON DELETE NO ACTION ON UPDATE CASCADE   
);

ALTER TABLE llevan
	DROP FOREIGN KEY fk_idAbogado,
    ADD CONSTRAINT fk_llevan_abogados FOREIGN KEY(idAbogado)
		REFERENCES abogados(idAbogado)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	ADD CONSTRAINT fk_llevan_casos FOREIGN KEY(idCasos, idTipoCaso)
		REFERENCES casos(idCasos, idTipoCaso)
        ON DELETE NO ACTION ON UPDATE CASCADE    
    ;

ALTER TABLE casos
	MODIFY COLUMN presupuesto DECIMAL(7, 2) UNSIGNED;


ALTER TABLE llevan
	DROP PRIMARY KEY,
    DROP FOREIGN KEY fk_llevan_casos,
    DROP FOREIGN KEY fk_llevan_abogados,
    
    DROP COLUMN idTipoCaso;

ALTER TABLE casos
	DROP PRIMARY KEY,
    DROP FOREIGN KEY fk_idTipoCaso,
    
    DROP COLUMN idTipoCaso,
    
    ADD CONSTRAINT pk_casos PRIMARY KEY(idCasos);
    
    
ALTER TABLE llevan
	ADD CONSTRAINT pk_llevan_nuevo PRIMARY KEY(idAbogado, idCasos),
    ADD CONSTRAINT fk_llevan_casos FOREIGN KEY(idCasos)
		REFERENCES casos(idCasos)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	ADD CONSTRAINT fk_llevan_abogados FOREIGN KEY(idAbogado)
		REFERENCES abogados(idAbogado)
        ON DELETE NO ACTION ON UPDATE CASCADE;

DROP TABLE tipoCasos;

/*ALTER TABLE llevan
	ADD COLUMN nomAbogado CHAR(20) AFTER idAbogado;*/














