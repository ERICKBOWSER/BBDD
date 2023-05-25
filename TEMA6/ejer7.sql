
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

SELECT extelem, COUNT(*), salarem, AVG(salarem)
FROM empleados
GROUP BY extelem
HAVING COUNT(*) BETWEEN 1 AND 3;

-- 3
/*
Prepara un procedimiento que, dado un código de promoción obtenga un listado con el 
nombre de las categorías que tienen al menos dos productos incluidos en dicha promoción.
*/
DROP PROCEDURE IF EXISTS act7_3;
DELIMITER $$
CREATE PROCEDURE act7_3
	(codigo INT)
BEGIN
	SELECT nomcat, count(*)
    FROM categorias
    JOIN articulos ON articulos.codcat = categorias.codcat
    JOIN catalogospromos ON catalogospromos.refart = articulos.refart
    WHERE catalogospromos.codpromo = codigo
    GROUP BY nomcat
    HAVING COUNT(*) > 2;
END $$
DELIMITER ;
CALL act7_3(1);

SELECT * FROM categorias;
SELECT * FROM promociones;
SELECT * FROM articulos;

/* 4 Prepara un procedimiento que, dado un precio, obtenga un listado con el 
nombre de las categorías en las que el precio  medio de sus productos supera 
a dicho precio.*/

DROP PROCEDURE IF EXISTS act7_4;
DELIMITER $$
CREATE PROCEDURE act7_4
	(precio DECIMAL(5,2))
BEGIN
	SELECT nomcat, precioventa, AVG(precioventa)
    FROM categorias
    JOIN articulos ON articulos.codcat = categorias.codcat
    group by nomcat
    HAVING AVG(precioventa) > precio;
END $$
DELIMITER ;
CALL act7_4(1);

/* 5 Prepara un procedimiento que muestre el importe total de las ventas por meses 
de un año dado.*/
DROP PROCEDURE IF EXISTS act7_5;
DELIMITER $$
CREATE PROCEDURE act7_5
	(IN anio INT)
BEGIN
	SELECT SUM(precioventa), MONTH(fecventa)
    FROM ventas
    JOIN detalleventa ON detalleventa.codventa = ventas.codventa
    WHERE YEAR(fecventa) = anio    
    GROUP BY MONTH(fecventa);
END $$
DELIMITER ;

CALL act7_5(2012);
SELECT * FROM ventas;






