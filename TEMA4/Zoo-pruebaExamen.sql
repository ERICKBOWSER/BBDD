/*
ZONAS(PK(codZona), desZona, nomZona)
EMPLEADOS(PK(codEmpleado), nombreEmpleado, desEmpleado)
CUIDADORES(PK(codCuidador), desCuidador, codEmpleado*)
VETERINARIOS(PK(codVeterinario), desVeterinario, codEmpleado*)
RECINTOS(PK(codRecinto, codZona*), desRecinto, nomRecinto, codCuidador)
ejemplares(PK(codEjemplar), desEjemplar, nomEjemplar, clase, padre, madre, alimentacion, codVeterinario)
esta(PK(codEjemplar, [codRecinto, codZona]*, fecInicio), observaciones, feciniestancia, fecfinestancia)

*/

CREATE DATABASE zoo_simulacroExam;
USE zoo_simulacroExam;

-- DROP DATABASE zoo_simulacroExam;

CREATE TABLE IF NOT EXISTS zonas
(
	codZona INT(10) NOT NULL,
    desZona VARCHAR(100),
    nomZona VARCHAR(15),
    
    CONSTRAINT pk_zonas PRIMARY KEY(codZona)
);

CREATE TABLE IF NOT EXISTS empleados
(
	codEmpleado INT(10) NOT NULL,
    nombreEmpleado VARCHAR(15),
    desEmpleado VARCHAR(100),
    
    CONSTRAINT pk_empleados PRIMARY KEY(codEmpleado)
);

CREATE TABLE IF NOT EXISTS cuidadores
(
	codCuidador INT(10) NOT NULL,
    desCuidador VARCHAR(100),
    codEmpleado INT(10),
    
    CONSTRAINT pk_cuidadores PRIMARY KEY(codCuidador),
    CONSTRAINT fk_cuidadores_empleado FOREIGN KEY(codEmpleado)
		REFERENCES empleados(codEmpleado)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS veterinarios
(
	codVeterinario INT(10) NOT NULL,
    desVeterinario VARCHAR(100),
    codEmpleado INT(10),
    
    CONSTRAINT pk_veterinarios PRIMARY KEY(codVeterinario),
    CONSTRAINT fk_veterinarios_empleado FOREIGN KEY(codEmpleado)
		REFERENCES empleados(codEmpleado)
        ON DELETE NO ACTION ON UPDATE CASCADE    
);

CREATE TABLE IF NOT EXISTS recintos
(
	codRecinto INT(10)NOT NULL,
    codZona INT(10) NOT NULL,
    desRecinto VARCHAR(100),
    nomRecinto CHAR(15),
    codCuidador INT(10),
    
    CONSTRAINT pk_recintos PRIMARY KEY(codRecinto, codZona),
    CONSTRAINT fk_recintos_zonas FOREIGN KEY(codZona)
		REFERENCES zonas(codZona)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_recintos_cuidador FOREIGN KEY(codCuidador)
		REFERENCES cuidadores(codCuidador)
        ON DELETE NO ACTION ON UPDATE CASCADE	
);

CREATE TABLE IF NOT EXISTS ejemplares
(
	codEjemplar INT(10) NOT NULL,
    desEjemplar VARCHAR(100),
    nomEjemplar CHAR(15),
    clase ENUM('peces', 'anfibios', 'reptiles', 'aves', 'mamiferos'),
    alimentacion SET('herbívora', 'carnívora', 'insectívora', 'fructivora'),
    padre INT(10),
    madre INT(10),
    codVeterinario INT(10),
    
    CONSTRAINT pk_ejemplares PRIMARY KEY(codEjemplar),
    CONSTRAINT fk_ejemplares_padre FOREIGN KEY(padre)
		REFERENCES ejemplares(codEjemplar)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_ejemplares_madre FOREIGN KEY(madre)
		REFERENCES ejemplares(codEjemplar)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_ejemplares_veterinario FOREIGN KEY(codVeterinario)
		REFERENCES veterinarios(codVeterinario)
        ON DELETE NO ACTION ON UPDATE CASCADE	
);

CREATE TABLE IF NOT EXISTS esta
(
	codEjemplar INT(10) NOT NULL,
    codRecinto INT(10),
    codZona INT(10),
    fecInicio DATE NOT NULL,
    observaciones VARCHAR(100),
    feciniestancia DATE NOT NULL,
    fecfinestancia DATE NULL,
    
    CONSTRAINT pk_esta PRIMARY KEY(codEjemplar, codRecinto, codZona, fecInicio),
    CONSTRAINT fk_esta_recintos FOREIGN KEY(codRecinto, codZona)
		REFERENCES recintos(codRecinto, codZona)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_esta_ejemplares FOREIGN KEY(codEjemplar)
		REFERENCES ejemplares(codEjemplar)
        ON DELETE NO ACTION ON UPDATE CASCADE   
    
);

ALTER TABLE empleados
	ADD COLUMN salario DECIMAL(6, 2) UNSIGNED;
    
ALTER TABLE ejemplares
	ADD CONSTRAINT nombre_unico UNIQUE(nomEjemplar),
    ADD COLUMN edad TINYINT(130) UNSIGNED,
    ADD COLUMN fechaNacimiento TIMESTAMP;

ALTER TABLE esta
	DROP PRIMARY KEY,
    DROP FOREIGN KEY fk_esta_recintos,
    DROP FOREIGN KEY fk_esta_ejemplares;
    
ALTER TABLE recintos
	ADD COLUMN observaciones VARCHAR(100),
    ADD COLUMN feciniestancia DATE,
    ADD COLUMN fecfinestancia DATE;


ALTER TABLE ejemplares
	ADD COLUMN observaciones VARCHAR(100),
    ADD COLUMN feciniestancia DATE,
    ADD COLUMN fecfinestancia DATE;

DROP TABLE esta;






























