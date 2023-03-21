
USE `empresaclase`;

/*
1. Prepara una rutina que, dado el número de un departamento, 
	devuelva el presupuesto del mismo.
2. Prepara una rutina que, dado el número de un empleado, nos devuelva 
	la fecha de ingreso en la empresa y el nombre de su director/a.
3. Prepara una rutina que muestre el nombre de todos los empleados y 
	el nombre del último departamento que ha dirigido (si es que  ha 
    dirigido alguno)
*/

-- 1
DROP FUNCTION IF EXISTS practicaRutina1;

DELIMITER //
CREATE FUNCTION practicaRutina1
	( departamento INT) RETURNS DECIMAL(10,2)

BEGIN
	DECLARE presupuesto DECIMAL(10, 2);
    
    SELECT presude INTO presupuesto FROM departamentos
		WHERE numde = departamento;
	RETURN presupuesto;
    
    -- Otra forma de hacerlo
    /*RETURN(SELECT presude FROM departamentos
			WHERE numde = departamento);*/
    
END ;
DELIMITER ;

SELECT practicaRutina1(1);
SELECT * FROM departamentos;

DROP PROCEDURE IF EXISTS practicaRutina2;
DELIMITER //
CREATE PROCEDURE practicaRutina2
	(IN empleado INT, OUT fecha DATE, OUT director INT)

BEGIN
	SELECT fecinem, dirigir.numempdirec INTO fechaIngreso, director
    FROM empleados
    JOIN departamentos ON empleados.numde = dirigir.numdepto
    
    
	



	/*SELECT fecinem AS "Fecha ingreso", nomem AS "Nombre" 
	FROM empleados
    JOIN dirigir ON dirigir.numempdirec = empleados.numem
		WHERE numem = 110;*/

END ;
DELIMITER ;

CALL practicaRutina2(110, @ingreso, @dir);
SELECT CONCAT('Fecha ingreso: ', @ingreso, ' director: ', IFNULL( @dir, 'sin director'));

DROP PROCEDURE IF EXISTS practicaRutina3;
DELIMITER //
CREATE PROCEDURE practicaRutina3
	(OUT)

DELIMITER //













