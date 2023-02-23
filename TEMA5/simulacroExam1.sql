
USE `GBDturRural2015`;

-- P1
INSERT INTO reservas(codreserva, codcliente, codcasa, fecreserva, numdiasestancia, pagocuenta)
	VALUES(3501, 520, 315, '2023/08/05', 7, 100);


-- P2
UPDATE caracteristicasdecasas
	SET codcaracter = 17,
		codcaracter = 3,
        codcaracter = 5
	WHERE codcasa = 350;

-- P3

START TRANSACTION;
	INSERT INTO devoluciones(numdevol, codreserva, importedevol)
		VALUES(226, 2450, 200);

	UPDATE reservas
		SET fecanulacion = CURDATE()
	WHERE codreserva = 2450;

COMMIT;

-- P4
START TRANSACTION;
	DELETE FROM casas
		WHERE codcasa = 5640;
        
	DELETE FROM casas
		WHERE codcasa = 5641;
        
	DELETE FROM propietarios
		WHERE codpropietario = 520;
        
COMMIT;

-- P5
UPDATE casas
	SET	numhabit = 3,
		m2 = 200,
        minpersonas = 4,
        maxpersonas = 8
	WHERE codcasa = 5789;















