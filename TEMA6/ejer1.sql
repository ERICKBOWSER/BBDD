
USE `empresaclase`;

-- 1
SELECT * FROM empleados;

-- 2
SELECT extelem, nomem, CONCAT_WS(ape1em, ape2em) 
	FROM empleados
	WHERE  nomem = "Juan" AND ape1em = "López" OR ape2em = "López";

-- 3
SELECT CONCAT(nomem, " ", ape1em, " ", ape2em) AS Nombre, numhiem 
	FROM empleados
	WHERE numhiem > 1;

-- 4
SELECT CONCAT(nomem, " ", ape1em, " ", ape2em) AS Nombre, numhiem 
	FROM empleados
	WHERE numhiem BETWEEN 1 AND 3;

-- 5
SELECT CONCAT(nomem, " ", ape1em, " ", ape2em) AS 'Nombre y apellidos', comisem
	FROM empleados
	WHERE comisem IS NULL OR comisem = 0;

-- 6
SELECT * FROM centros;

SELECT dirce 
	FROM centros
	WHERE nomce = "SEDE CENTRAL";

-- 7
SELECT nomde, presude
	FROM departamentos
	WHERE presude > 6000;

-- 8
SELECT nomde, presude
	FROM departamentos
	WHERE presude >= 6000;

-- 9
SELECT CONCAT(nomem, " ", ape1em, " ", ape2em) AS 'Nombre y apellidos', fecinem
	FROM empleados
	WHERE fecinem > DATE_ADD(fecinem, INTERVAL 1 YEAR);

SELECT nomem, fecinem FROM empleados;



































