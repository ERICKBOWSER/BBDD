
USE BDMUSEO;

INSERT INTO artistas (codartista, nomartista)
	VALUES(1, "Vicent van Goh"),
		(2, "Eva Gonzales"),
        (3, "Rafael Mengs"),
        (4, "Pablo Ruiz Picasso"),
        (5, "Salvador Dalí"),
        (6, "Joan Miró");
        
INSERT INTO estilos (codestilo, desestilo)
	VALUES(1, "ABSTRACTO"),
		(2, "REALISMO"),
        (3, "SURREALISMO"),
        (4, "IMPRESIONISMO"),
        (5, "BARROCO"),
        (6, "POP"),
        (7, "EXPRESIONISMO"),
        (8, "DETALLISMO"),
        (9, "NEOCLASICISMO");
        
INSERT INTO salas (codsala, nomsala, ubicacion)
	VALUES(1, "primera sala", 101),
		(2, "segunda sala", 102),
        (3, "tercera sala", 103),
        (4, "cuarta sala", 201),
        (5, "quinta sala", 202),
        (6, "almacén 1", 308),
        (7, "almacén 2", 309),
        (8, "despacho restauración 1", 308), 
        (9, "despacho restauración 2", 307);
        
INSERT INTO empleados (codemple, nomemle, ape1emple, ape2emple)        
	VALUES (110, "PEPA", "PEREZ", NULL),
		(120, "JUAN", "LOPEZ", NULL),
        (130, "ANA", "GARCIA", NULL),
        (150, "JULIA", "VARGAS", NULL),
        (160, "PEPA", "CANALES", NULL),
        (180, "JUANA", "RODRIGUEZ", "PEREZ"),
		(190, "LUISA", "GOMEZ", NULL),
        (210, "CESAR", "PONS", NULL),
        (240, "MARIO", "LASA", NULL),
        (250, "LUCIANO", "TEROL", NULL),
        (260, "JULIO", "PEREZ", NULL),
        (270, "AUREO", "AGUIRRE", NULL),
        (280, "MARCOS", "PEREZ", NULL),
        (290, "PILAR", "GALVEZ", NULL),
        (310, "LAVINIA", "SANZ", NULL),
        (320, "ADRIANA", "ALBA", NULL),
        (330, "ANTONIO", "LOPEZ", NULL),
        (350, "OCTAVIO", "GARCIA", NULL),
        (360, "DOROTEA", "FLOR", NULL),
        (370, "OTILIA", "POLO", NULL),
        (380, "GLORIA", "GUIL", NULL),
        (390, "AUGUSTO", "GARCIA", NULL),
        (400, "CORNELIO", "SANZ", NULL),
        (410, "DORINDA", "LARA", NULL),
        (420, "FABIOLA", "RUIZ", NULL),
        (430, "MICAELA", "MARTIN", NULL),
        (440, "CARMEN", "MORAN", NULL),
        (450, "LUCRECIA", "LARA", NULL),
        (480, "AZUCENA", "MUÑOZ", NULL),
        (490, "CLAUDIA", "FIERRO", NULL),
        (500, "VALERIANA", "MORA", NULL),
        (510, "LIVIA", "DURAN", NULL),
        (550, "DIANA", "PINO", NULL),
        (560, "HONORIA", "TORRES", NULL),
        (570, "MARÍA", "VALLE", "DEL RÍO"),
        (580, "JAVIER", "LÓPEZ", "CAMPOS");
        
INSERT INTO seguridad(codsegur, codemple, codsala)
        VALUES	(1, 110, 1),
			(2, 120, 1),
            (3, 130, 2),
            (4, 150, 1),
            (5, 160, 3),
            (6, 180, 4),
            (7, 190, 5),
            (8, 210, 6),
            (9, 240, 6),
            (10, 250, 5),
            (11, 260, 6),
            (12, 270, 7),
            (13, 280, 5),
            (14, 285, 8),
            (15, 290, 9),
            (16, 310, 2),
            (17, 320, 2),
            (18, 330, 4),
            (19, 350, 5),
            (20, 360, 7),
            (21, 370, 7),
            (22, 380, 8),
            (23, 390, 8),
            (24, 400, 8),
            (25, 410, 9),
            (26, 420, 9),
            (27, 430, 7),
            (28, 440, 8),
            (29, 450, 1),
            (30, 480, 2),
            (31, 490, 3),
            (32, 500, 3),
            (33, 510, 4),
            (34, 550, 4),
            (35, 560, 5);
            
INSERT INTO restauradores (codrestaurador, codemple, especialidad)
	VALUES(1, 570, "Salvador Dalí"),
		(2, 580, "Expresionistas");

INSERT INTO tipobras (codtipobra, destipobra)
	VALUES (1, "PINTURA"),
		(2, "ESCULTURA");


INSERT INTO obras (codobra, nomobra, codartista, codtipobra, codestilo, valoracion, codubicacion)
	VALUES(1, "LA MASÍA", 6, 1, 8, 700000, 1),
			(2, "CABEZA DE FUMADOR", 6, 1, 3, 400000, 1),
            (3, "LA PERSISTENCIA DE LA MEMORIA", 5, 1, 3, 0, 2),
            (4, "TRITÓN ALADO", 5, 2, 3, 0, 3),
            (5, "ANGEL SURREALISTA", 5, 2, 3, 0, 3),
            (6, "LA SOMBRERERA", 2, 1, 4, 0, 2),
            (7, "GRANJA EN REBAIS", 2, 1, 4, 0, 1),
            (8, "TE POR LA TARDE", 2, 1, 4, 0, 5),
            (9, "EL TRIUNFO DE LA AURORA", 3, 1, 9, 0, 4);
            

-- Ejer 11
UPDATE empleados
	SET nomemple = "Carmen",
		ape1emple = "Gómez",
        ape2emple = "Pérez",
        numsegsoc = "0000000000001",
        fecincorp = CURDATE()
    WHERE codemple = 1;

INSERT INTO seguridad (codsegur, codemple)
	VALUES (50, 1);
    
-- Ejer 12






SELECT * FROM tipobras;












