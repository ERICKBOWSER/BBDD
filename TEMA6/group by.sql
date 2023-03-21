-- CUANTOS EMPLEADOS HAY
USE `empresaclase`;

SELECT COUNT(*), COUNT(numem), COUNT(DISTINCT numde) -- CUENTA CELDAS
	FROM empleados;
    
-- Cuanto me cuesta al mes pagar a mis empleaos

SELECT SUM(salarem)
FROM empleados;

-- Cual es el salario minimo
SELECT MIN(salarem)
FROM empleados;

-- Cual es el salario maximo
SELECT MAX(salarem)
FROM empleados;
    
-- Cual es la media de los salarios
SELECT AVG(salarem)
FROM empleados;

SELECT numde, COUNT(*) AS numEMpleados, SUM(salarem) AS TotalSalar, MAX(salarem) AS salarMax, MIN(salarem) AS salarMin
	, AVG(salarem) as salarMedio
FROM empleados
GROUP BY numde;

-- Rutina que devuelva el número de extensiones telefónicas que usa un departamento dado

DROP PROCEDURE IF EXISTS numExtensiones;
DELIMITER //
CREATE FUNCTION numExtensiones
	(departamento INT)
    RETURNS INT
    DETERMINISTIC
BEGIN
	RETURN(SELECT COUNT(DISTINCT extelem) 
    FROM empleados
    );	
END ;
DELIMITER //
    
SELECT nomde, numExtensiones(numde)
FROM departamentos
ORDER BY nomde;
    
    
    
    
    
    
    
    
    