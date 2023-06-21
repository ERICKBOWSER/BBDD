CREATE DATABASE fam;
USE fam;

CREATE TABLE IF NOT EXISTS clientes
(
	codCliente INT(10) NOT NULL,
    nombre VARCHAR(10) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20),
    email VARCHAR(30) UNIQUE,
    
    CONSTRAINT pk_clientes PRIMARY KEY(codCliente),
    CONSTRAINT email_unico UNIQUE(email)
);

CREATE TABLE IF NOT EXISTS menus
(
	codMenuDiario INT(10) NOT NULL,
    fecha DATE,
    numSemana TINYINT(10),
    codCliente INT(10),
    
    CONSTRAINT pk_menus PRIMARY KEY(codMenuDiario),
	CONSTRAINT fk_menus_clientes FOREIGN KEY(codcliente)
		REFERENCES clientes(codCliente)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS recetas
(
	codReceta INT(10) NOT NULL,
    nombreReceta VARCHAR(100) NOT NULL,
    elaboracion VARCHAR(600) NULL,
    codCreado INT(10),
    
    CONSTRAINT pk_recetas PRIMARY KEY(codReceta),
    CONSTRAINT fk_recetas_creado FOREIGN KEY(codCreado)
		REFERENCES clientes(codCliente)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ingredientes
(
	codIngredientes INT(10) NOT NULL,
    nombreIngrediente VARCHAR(100) NOT NULL,
    carbohidratos DECIMAL(4,2),
    proteinas DECIMAL(4,2),
    grasas DECIMAL(4,2),
    tipo ENUM("proteínas", "grasas", "cereales", "verduras", "frutas"),

	CONSTRAINT pk_ingredientes PRIMARY KEY(codIngredientes)
);

CREATE TABLE IF NOT EXISTS platos
(
	codMenuDiario INT(10) NOT NULL,
    codReceta INT(10) NOT NULL,
    comida VARCHAR(50) NOT NULL,
    
    CONSTRAINT pk_platos PRIMARY KEY(codMenuDiario, codReceta),
    CONSTRAINT fk_platos_menus FOREIGN KEY(codMenuDiario)
		REFERENCES menus(codMenuDiario)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_platos_recetas FOREIGN KEY(codReceta)
		REFERENCES recetas(codReceta)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS listaRechazadosRecetas
(
	codCliente INT(10) NOT NULL,
    codReceta INT(10) NOT NULL,
    fechaRechazo DATE NOT NULL,
    
    CONSTRAINT pk_listaRechazadosRecetas PRIMARY KEY(codCliente, codReceta),
    CONSTRAINT fk_listaRechazados_clientes FOREIGN KEY(codCliente)
		REFERENCES clientes(codCliente)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_listaRechazados_recetas FOREIGN KEY(codReceta)
		REFERENCES recetas(codReceta)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS listIngredientes
(
	codReceta INT(10) NOT NULL,
    codIngredientes INT(10) NOT NULL,
    cantidad INT(10) NOT NULL,
    
    CONSTRAINT pk_listIngredientes PRIMARY KEY(codReceta, codIngredientes),
    CONSTRAINT fk_listIngredientes_recetas FOREIGN KEY(codReceta)
		REFERENCES recetas(codReceta)
        ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_listIngredientes_ingredientes FOREIGN KEY(codIngredientes)
		REFERENCES ingredientes(codIngredientes)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS listaRechaIngre
(
	codCliente INT(10) NOT NULL,
    codIngredientes INT(10) NOT NULL,
    fechaRechazo DATE NOT NULL,
    
    CONSTRAINT pk_listaRechaIngre PRIMARY KEY(codCliente, codIngredientes),
    CONSTRAINT fk_listaRechaIngre_clientes FOREIGN KEY(codCliente)
		REFERENCES clientes(codCliente)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_listaRechaIngre_ingredientes FOREIGN KEY(codIngredientes)
		REFERENCES ingredientes(codIngredientes)
        ON DELETE NO ACTION ON UPDATE CASCADE
);


INSERT INTO clientes (codCliente, nombre, apellido1, apellido2, email)
VALUES (1, 'Juan', 'Pérez', 'Gómez', 'juanperez@mail.com'),
	(2, 'María', 'González', 'Fernández', 'mariagonzalez@mail.com'),
    (3, 'Pedro', 'Sánchez', 'Jiménez', 'pedrosanchez@mail.com'),
    (4, 'Ana', 'Martínez', 'Ruiz', 'anamartinez@mail.com'),
    (5, 'Miguel', 'Hernández', 'Pérez', 'miguelhernandez@mail.com'),
     (6, 'Sofía', 'López', 'Santos', 'sofialopez@mail.com'),
      (7, 'David', 'García', 'Martín', 'davidgarcia@mail.com'),
      (8, 'Elena', 'Rodríguez', 'Vázquez', 'elenarodriguez@mail.com');


INSERT INTO menus (codMenuDiario, fecha, numSemana, codCliente)
VALUES (1, '2023-05-8', 18, 1),
		(2, '2023-05-8', 18, 2),
        (3, '2023-05-10', 19, 3),
        (4, '2023-05-10', 19, 4),
        (5, '2023-05-13', 19, 5),
        (6, '2023-05-13', 19, 6),
        (7, '2023-05-17', 19, 7),
        (8, '2023-05-17', 19, 8);

INSERT INTO menus (codMenuDiario, fecha, numSemana, codCliente)
VALUES (9, '2023-05-1', 18, 1),
		(10, '2023-05-1', 18, 2);

INSERT INTO recetas (codReceta,nombreReceta, elaboracion, codCreado)
VALUES (1, 'Ensalada de quinoa y pollo','sdfnhksdañklfja', 1),
	(2, 'Salteado de verduras y tofu','sdfnhksdañklfja', 2),
	(3, 'Arroz con pollo','sdfnhksdañklfja', 3),
	(4, 'Tarta de manzana','sdfnhksdañklfja', 4),
	(5, 'Gazpacho andaluz','sdfnhksdañklfja', 5),
	(6, 'Lasaña de carne','sdfnhksdañklfja', 6),
	(7, 'Pisto','sdfnhksdañklfja', 7),
	(8, 'Crema de calabaza','sdfnhksdañklfja', 8);


INSERT INTO ingredientes (codIngredientes, carbohidratos, proteinas, grasas, tipo, nombreIngrediente)
VALUES (1, 20.5, 6.2, 2.8, 'proteínas','pollo'),
	   (2, 13.8, 1.9, 0.9, 'cereales','arroz'),
	   (3, 4.2, 2.1, 0.5, 'verduras','pimiento'),
	   (4, 3.5, 0.5, 0.1, 'frutas','manzana'),
	   (5, 7.0, 2.2, 1.1, 'grasas','aceite de oliva virgen extra'),
	   (6, 12.0, 2.8, 1.5, 'proteínas','merluza'),
	   (7, 20.5, 30.2, 10.7, 'proteínas','tofu'),
	   (8, 45.3, 10.1, 7.8, 'cereales','quinoa');



INSERT INTO platos (codMenuDiario, codReceta, comida)
VALUES (1, 1, 'Almuerzo'),
	   (1, 2, 'Cena'),
       (2, 3, 'Almuerzo'),
       (2, 4, 'Almuerzo'),
       (3, 5, 'Cena'),
       (3, 6, 'Cena'),
       (4, 7, 'Almuerzo'),
       (4, 8, 'Cena');

INSERT INTO platos (codMenuDiario, codReceta, comida)
VALUES (9, 1, 'Almuerzo'),
	   (10, 2, 'Cena');

INSERT INTO listaRechazadosRecetas (codCliente, codReceta, fechaRechazo)
VALUES (2, 1, '2023-05-08'),
	(2, 2, '2023-05-09');



INSERT INTO listIngredientes (codReceta, codIngredientes, cantidad)
VALUES (1, 3, 200), (1, 6, 100), (1, 7, 150),
	   (2, 2, 300), (2, 3, 200), (2, 5, 50),
       (3, 2, 150), (3, 6, 100), (3, 7, 200),
       (4, 4, 250), (4, 8, 150), (4, 2, 100),
       (5, 3, 200), (5, 4, 100), (5, 5, 50),
       (6, 1, 200), (6, 6, 150), (6, 2, 100),
       (7, 3, 300), (7, 1, 150), (7, 7, 200),
       (8, 8, 250), (8, 2, 150), (8, 4, 100);



INSERT INTO listaRechaIngre (codCliente, codIngredientes, fechaRechazo)
VALUES (1, 2, '2023-05-08'),
	(2, 1, '2023-05-09');


-- Crear receta
drop procedure if exists crearReceta;
delimiter $$
create procedure crearReceta(keyReceta int, nombreR varchar(100), elabor varchar(600), creador int)
	begin
		insert into recetas 
        (codReceta,nombreReceta, elaboración, codCreado)
		values
		(keyReceta, nombreR, elabor, creador);
		
	end $$
delimiter ;

-- Añadir ingrediente

create procedure addIngrediente(receta int, ingrediente int, catidad int)
	begin
		insert into listingredientes
        (codReceta,codIngredientes,cantidad)
        values
        (receta, ingrediente, cantidad);
    end $$
delimiter ;





















