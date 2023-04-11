
USE `GBDturRural2015`;

-- 1
SELECT * FROM casas
	WHERE minpersonas BETWEEN 4 AND 6 AND provincia = "Sevilla";

-- 2
SELECT devoluciones.codreserva, importedevol, CONCAT(nomcli, " ", ape1cli, IFNULL(CONCAT(" ", ape2cli), "")) AS 'Nombre completo'
FROM devoluciones
JOIN reservas ON reservas.codreserva = devoluciones.codreserva
RIGHT JOIN clientes ON clientes.codcli = reservas.codcliente;
		
SELECT * FROM devoluciones;

-- 3
DROP PROCEDURE IF EXISTS sim3_g1;
DELIMITER $$
CREATE PROCEDURE sim3_g1
	(IN codCaracteristica INT)
BEGIN
	SELECT casas.codcasa, casas.nomcasa, casas.poblacion, tiposcasa.nomtipo, casas.preciobase
	FROM casas
    JOIN tiposcasa ON tiposcasa.numtipo = casas.codtipocasa
    JOIN caracteristicasdecasas ON caracteristicasdecasas.codcasa = casas.codcasa
		WHERE caracteristicasdecasas.codcaracter = codCaracteristica
		ORDER BY casas.poblacion, casas.preciobase DESC;
END $$
DELIMITER ;

CALL sim3_g1(1);
SELECT * FROM caracteristicasdecasas;
SELECT * FROM casas;
SELECT * FROM caracteristicas;

INSERT INTO caracteristicasdecasas VALUES(1, 1, 1, "ejemplo");

-- 4 
DROP PROCEDURE IF EXISTS sim4_g1;
DELIMITER $$
CREATE PROCEDURE sim4_g1
	(IN codigo INT)
BEGIN
	SELECT nomcasa, poblacion
	FROM casas
		WHERE codzona = codigo;
END $$
DELIMITER ;

CALL sim4_g1(1);

-- 6
DROP PROCEDURE IF EXISTS sim6_g1;
DELIMITER $$
CREATE PROCEDURE sim6_g1
	(IN reserva INT, OUT telefono CHAR(9), OUT nombre VARCHAR(50))
BEGIN
	SELECT tlf_contacto, CONCAT(ape1cli, " ", IFNULL(CONCAT(ape2cli, ""), ""), ", ", nomcli) AS 'Nombre completo' INTO telefono, nombre
    FROM clientes
    JOIN reservas ON reservas.codcliente = clientes.codcli
		WHERE codreserva = reserva;
END $$
DELIMITER ;

-- SELECT * FROM clientes;

CALL sim6_g1(2, @telefono, @nombre);

SELECT @telefono, @nombre;


















