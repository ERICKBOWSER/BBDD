
USE `GBDturRural2015`;

-- P1
START TRANSACTION;
	INSERT INTO clientes(codcli, nomcli, ape1chi, ape2cli, dnicli, tlf_contacto, correoelectronico, dircli, pobcli, provcli, codpostalcli)
			VALUES(899, "Juan", "del Campo", "Sánchez", "07000001W", 607000001, NULL, NULL, NULL, NULL, NULL);
            
	UPDATE reservas
		SET codcliente = 899
        WHERE codreserva = 4356;
COMMIT;

-- P2
DELETE FROM reserva
	WHERE codcliente = 456 AND fecreserva = CURDATE();
    
-- P3
UPDATE propietarios
	SET tlf_contacto = 789000000,
		correoelectronico = "dfg@gmail.com"
	WHERE codpropietario = 789;
    
-- P4
START TRANSACTION;
	DELETE FROM caracteristicasdecasas
		WHERE codcaracter = 230 OR codcaracter = 245;
    
	DELETE FROM caracteristicas
		WHERE numcaracter = 230 OR numcaracter = 245;
COMMIT;

-- P5
UPDATE casas
	SET preciobase = preciobase + 1.10
    WHERE numbanios = 3 AND m2 = 200;




































