

/*
Para la base de datos “empresa_clase” obtener, dado el código de un empleado, la 
contraseña de acceso formada por:
Inicial del nombre + 10 caracteres.
Tres primeras letras del primer apellido + 5 caracteres.
Tres primeras letras del segundo apellido (o “LMN” en caso de no tener 2º apellido) 
+ 5 caracteres.
*/
-- 1 (Falta DNI)
DROP PROCEDURE IF EXISTS act6_1;
DELIMITER $$
CREATE PROCEDURE act6_1
	(IN codigo INT)
BEGIN
	SELECT CONCAT(LEFT(nomem, 1), "-qwertyuiop",
		LEFT(ape1em, 3), "-asdfg",
        CONCAT(IFNULL(ape2em, "-LMN"), "-ñlkjh"))
	FROM empleados
	WHERE codigo = numem;
END $$
DELIMITER ;

CALL act6_1(1);

SELECT * FROM empleados;

-- 2 (FALTA 2do APELLIDO)
DROP PROCEDURE IF EXISTS act6_2;
DELIMITER $$
CREATE PROCEDURE act6_2
	()
BEGIN
	SELECT LEFT(nomcontacto, LOCATE(" ", nomcontacto)), 
		SUBSTRING(nomcontacto, LOCATE(" ", nomcontacto))
	FROM proveedores;

END $$
DELIMITER ;

CALL act6_2();

-- 3
DROP PROCEDURE IF EXISTS act6_3;
DELIMITER $$
CREATE PROCEDURE act6_3
	()
BEGIN
	SELECT ROUND(salarem * 1.05, 2), salarem
    FROM empleados;
END $$
DELIMITER ;

CALL act6_3;

-- 4  ??

-- 5 IMPORTANTE: no funciona con DATEDIFF()
DROP PROCEDURE IF EXISTS act6_6;
DELIMITER $$
CREATE PROCEDURE act6_6
	(IN codigo INT)
BEGIN
	SELECT TIMESTAMPDIFF(YEAR, fecnaem, CURDATE()) AS 'Edad', fecnaem, CURDATE()
    FROM empleados
	WHERE numem = codigo;
END $$
DELIMITER ;

CALL act6_6(1);

-- 6 NO FUNCIONA
/*
SELECT DAYOFMONTH(feciniem, INTERVAL 3 MONTH) AS 'Prueba'
FOR empleados
WHERE numem = 2;
*/

-- 7 ??

-- 8 NO FUNCIONA
/*
SELECT CONVERT(varchar, CURDATE(), 104) AS [DD/MM/YY]
FROM empleados
WHERE numem = 2;
*/

-- 9

-- 10































