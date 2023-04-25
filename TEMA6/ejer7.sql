
-- 1
/*
Hallar el salario medio para cada grupo de empleados con igual comisión y para los que 
no la tengan, pero solo nos interesan aquellos grupos de comisión en los que haya más 
de un empleado.
*/

SELECT AVG(salarem), salarem, comisem
FROM empleados
GROUP BY comisem, comisem IS NULL
HAVING COUNT(comisem) > 1;

SELECT * FROM empleados;

-- 2
/*
Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio 
de éstos. Solo nos interesan aquellos grupos en los que hay entre 1 y 3 empleados.
*/

SELECT extelem, COUNT(numem), AVG(salarem)
FROM empleados
GROUP BY extelem
HAVING COUNT(numem) BETWEEN 1 AND 3;


-- 3
/*
Prepara un procedimiento que, dado un código de promoción obtenga un listado con el 
nombre de las categorías que tienen al menos dos productos incluidos en dicha promoción.
*/

DROP PROCEDURE IF EXISTS act7_3;
DELIMITER $$
CREATE PROCEDURE act7_3
	(IN codigo INT)
BEGIN
	SELECT nomcat
    FROM categorias
    JOIN articulos ON articulos.codcat = categorias.codcat
    JOIN catalogospromos ON catalogospromos.refart = articulos.refart
    JOIN promociones ON promociones.codpromo = catalogospromos.codpromo
    WHERE promociones.codpromo = codigo
    GROUP BY categorias.nomcat > 2;
END $$
DELIMITER ;

CALL act7_3(2);
SELECT * FROM categorias;
SELECT * FROM promociones;
SELECT * FROM articulos;

-- 4
DROP PROCEDURE IF EXISTS act7_4;
DELIMITER $$
CREATE PROCEDURE act7_4
	(IN precio DECIMAL(5,2))
BEGIN
	SELECT nomcat, AVG(preciobase)
    FROM categorias
    JOIN articulos ON articulos.codcat = categorias.codcat
    GROUP BY nomcat
    HAVING AVG(preciobase) > precio;   
END $$
DELIMITER ;

CALL act7_4(8);

-- 5
DROP PROCEDURE IF EXISTS act7_5;
DELIMITER $$
CREATE PROCEDURE act7_5
	(IN anio INT)
BEGIN
	SELECT SUM(precioventa), MONTH(fecventa)
    FROM ventas
    JOIN detalleventa ON detalleventa.codventa = ventas.codventa
    WHERE YEAR(fecventa) = anio;
END $$
DELIMITER ;

CALL act7_5(2012);
SELECT * FROM ventas;














