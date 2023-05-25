

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
        CONCAT(IFNULL(LEFT(ape2em, 3), "-LMN"), "-ñlkjh"))
	FROM empleados
	WHERE codigo = numem;
END $$
DELIMITER ;

CALL act6_1(1);

/* 2 Para la base de datos “BDAlmacen” obtener por separado el nombre, el primer 
apellido y el segundo apellido de los proveedores.
*/
DROP PROCEDURE IF EXISTS act6_2;
DELIMITER $$
CREATE PROCEDURE act6_2
	()
BEGIN
	SELECT LEFT(nomcontacto, LOCATE(" ", nomcontacto)), 
		SUBSTRING(nomcontacto, LOCATE(" ", nomcontacto)),
        RIGHT(SUBSTRING(nomcontacto, LOCATE(" ", nomcontacto) + 1), 
			LOCATE(' ', SUBSTRING(nomcontacto, LOCATE(' ', nomcontacto)+ 1))) AS 'Apellido2'
	FROM proveedores;

END $$
DELIMITER ;

CALL act6_2();

/* 3 Obtener un procedimiento que obtenga el salario de los empleados incrementado 
en un 5%. El formato de salida del salario incrementado debe ser con dos decimales.
*/
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

/* 4  Prepara una función que determine si un valor que se pasa como parámetro es 
una fecha correcta o no.*/

/* 5 Para la base de datos “Empresa_clase” prepara un procedimiento que devuelva 
la edad de un empleado.
*/
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

/* 6 Para la base de datos “EMPRESA_CLASE” obtener el día que termina el periodo de 
prueba de un empleado, dado su código de empleado. El periodo de prueba será de 3 meses.
*/
DROP FUNCTION IF EXISTS act6_6;
DELIMITER $$
CREATE FUNCTION act6_6
(empleado INT)
RETURNS DATE
LANGUAGE SQL
DETERMINISTIC

BEGIN
	DECLARE resultado DATE;

	SELECT DATE_ADD(IFNULL(fecinem, CURDATE()), INTERVAL 3 MONTH) INTO resultado
	FROM empleados
	WHERE numem = empleado;

	RETURN resultado;
END $$
DELIMITER ;

SELECT act6_6(1);

-- 7 ??

/* 8 Obtener el nombre completo de los empleados y la fecha de nacimiento con 
los siguientes formatos:

date_format varios formatos 
1. “05/03/1978”
2. 5/3/1978
3. 5/3/78
4. 05-03-78
5. 05 Mar 1978
6. 5 de marzo de 1978
7. Miércoles, 25 de marzo de 2015
*/
select date_format(curdate(), '%d/%m/%Y'),
date_format(Curdate(), '%e/%c/%Y'),
date_format(curdate(), '%e/%c/%y'),
date_format(curdate(), '%d-%m-%y'),
date_format(curdate(), '%d %b %Y'),
date_format(curdate(), '%e de %M de %Y'),
date_format(curdate(), '%W, %2 de %M de %Y');

select date_format(curdate(),'En Estepona a %e de %M de %Y');

-- 9

-- 10































