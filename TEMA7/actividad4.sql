
/* 1. Obtener por orden alfabético el nombre y los sueldos de los empleados con 
más de tres hijos.*/
SELECT nomem, salarem FROM empleados
WHERE numhiem > 3 
ORDER BY nomem;

/*	2. Obtener la comisión, el departamento y el nombre de los empleados cuyo salario 
es inferior a 190.000 u.m., clasificados por departamentos en orden creciente y por 
comisión en orden decreciente dentro de cada departamento.
*/
SELECT comisem, empleados.numde, departamentos.nomde, nomem, salarem FROM empleados
JOIN departamentos ON departamentos.numde = empleados.numde
WHERE salarem < 190000
ORDER BY departamentos.nomde ASC, empleados.comisem DESC;

/* 3. Hallar por orden alfabético los nombres de los deptos cuyo director lo es en 
funciones y no en propiedad.
*/
SELECT nomde, tipodir FROM departamentos
JOIN dirigir ON dirigir.numdepto = departamentos.numde
WHERE tipodir = "f"
ORDER BY nomde;

/* 4. Obtener un listín telefónico de los empleados del departamento 121 incluyendo el 
nombre del empleado, número de empleado y extensión telefónica. Ordenar alfabéticamente.
*/

SELECT CONCAT_WS(' ', ape1em, ape2em, nomem) , extelem, numde, numem FROM empleados
WHERE numde = 121
ORDER BY nomem;

/* 5. Hallar la comisión, nombre y salario de los empleados con más de tres hijos, 
clasificados por comisión y dentro de comisión por orden alfabético.
*/
SELECT comisem, nomem, salarem, numhiem FROM empleados
WHERE numhiem > 3
ORDER BY comisem ASC, nomem ASC;

/* 6. Hallar por orden de número de empleado, el nombre y salario total (salario más 
comisión) de los empleados cuyo salario total supere las 300.000 u.m. mensuales.
*/
SELECT numem, nomem, (salarem + IFNULL(comisem, 0)) AS 'Salario total' FROM empleados
WHERE salarem + IFNULL(comisem, 0) > 300.000
ORDER BY numem;

/* 7. Obtener los números de los departamentos en los que haya algún empleado cuya 
comisión supere al 20% de su salario.
*/
SELECT numde, comisem, (0.20 * salarem) AS '20%' FROM empleados
WHERE IFNULL(comisem, 0) > 0.20 * salarem;

/* 8. Hallar por orden alfabético los nombres de los empleados tales que si se les da 
una gratificación de 100 u.m. por hijo el total de esta gratificación no supere a la 
décima parte del salario.
*/
SELECT nomem, numhiem , salarem, (numhiem * 100) AS 'Gratificación'
FROM empleados
WHERE numhiem > 0 AND numhiem * 100 <= salarem / 10
ORDER BY nomem;

/* 9. Llamaremos presupuesto medio mensual de un depto. al resultado de dividir su 
presupuesto anual por 12. Supongamos que se decide aumentar los presupuestos medios 
de todos los deptos en un 10% a partir del mes de octubre inclusive. Para los deptos. 
cuyo presupuesto mensual anterior a octubre es de más de 500.000 u.m. Hallar por 
orden alfabético el nombre de departamento y su presupuesto anual total después del 
incremento.
*/
DROP PROCEDURE IF EXISTS act4_9;
DELIMITER $$
CREATE PROCEDURE act4_9()
BEGIN
	SELECT nomde, (presude / 12*9) + (presude / 12*3*1.1) AS total
    FROM departamentos
    WHERE presude / 12*9 > 50000
    ORDER BY nomde;
END $$
DELIMITER ;

CALL act4_9();

/* 10. Suponiendo que en los próximos tres años el coste de vida va a aumentar un 6% anual 
y que se suben los salarios en la misma proporción. Hallar para los empleados con más de cuatro 
hijos, su nombre y sueldo anual, actual y para cada uno de los próximos tres años, clasificados 
por orden alfabético.
*/
DROP PROCEDURE IF EXISTS act4_10;
DELIMITER $$
CREATE PROCEDURE act4_10
	()
    BEGIN
		SELECT numhiem, nomem, salarem, (salarem * 1.06) AS 'Sueldo anual', 
			salarem * 1.06 * 1.06 AS 'Salario en 2 años',
            salarem * 1.06 * 1.06 * 1.06 AS 'Salario en 3 años'
		FROM empleados
		ORDER BY nomem;
    END $$
DELIMITER ;

CALL act4_10();

SELECT * FROM dirigir;























