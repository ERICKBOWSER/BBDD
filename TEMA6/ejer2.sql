
USE `empresaclase`;

DROP PROCEDURE IF EXISTS ejer_2_7;
DELIMITER $$
CREATE PROCEDURE ejer_2_7;

BEGIN
	SELECT departamentos.nomde, departamentos.presude
    FROM departamentos JOIN centros ON departamentos.numce = centros.numce
    WHERE LOWER(TRIM())



















