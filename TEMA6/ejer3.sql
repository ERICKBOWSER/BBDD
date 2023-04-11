
-- 1
DROP PROCEDURE IF EXISTS act3_ejer1;
DELIMITER $$
CREATE PROCEDURE act3_ejer1 ()
BEGIN
	SELECT MAX(salarem) FROM empleados;
END $$
DELIMITER ;

CALL act3_ejer1();

-- 2
DROP PROCEDURE IF EXISTS act3_ejer2;
DELIMITER $$
CREATE PROCEDURE act3_ejer2()
BEGIN
	SELECT MIN(salarem) FROM empleados;
END $$
DELIMITER ;

CALL act3_ejer2();

-- 6
DROP PROCEDURE IF EXISTS act3_ejer6;
DELIMITER $$
CREATE PROCEDURE act3_ejer6
	(IN departamento INT)
BEGIN
	SELECT SUM(salarem) 
    FROM empleados
     WHERE numde = departamento;
END $$
DELIMITER ;

CALL act3_ejer6(111);


SELECT * FROM departamentos;
SELECT * FROM empleados;















