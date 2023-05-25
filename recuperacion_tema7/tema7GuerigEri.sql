-- p4
DROP VIEW p4;
CREATE VIEW p4 AS
	SELECT CONCAT_WS(' ', nomsocio, ape1socio, ape2socio) AS nombre, dirpostal, codsocio
    FROM socios;

SELECT * FROM p4;


-- p5
DROP PROCEDURE IF EXISTS p5;
DELIMITER $$
CREATE PROCEDURE p5
	(IN anio INT(10))
BEGIN     
	SELECT COUNT(*), SUM(importe), codcafet, MONTH(fechacomanda)
    FROM comandas
    WHERE YEAR(fechacomanda) = anio
    GROUP BY codcomanda
    HAVING COUNT(*) > 5;    

END $$
DELIMITER ;
CALL p5(2020);

/*
DROP PROCEDURE IF EXISTS p5;
DELIMITER $$
CREATE PROCEDURE p5
	(IN anio INT(10), OUT numero INT(10), OUT importeRes DECIMAL(12,2))
BEGIN     
	SELECT COUNT(*), SUM(importe) INTO numero, importeRes
    FROM comandas
    WHERE YEAR(fechacomanda) = anio
    GROUP BY MONTH(fechacomanda)
    HAVING count(*) < 1;
END $$
DELIMITER ;
CALL p5(2020, @numero, @importe);

SELECT @numero, @importe;
*/

-- P6
DROP PROCEDURE IF EXISTS p6;
DELIMITER $$
CREATE PROCEDURE p6
	()
BEGIN     
	SELECT  concat_ws(' ', nomemp, ape1emp, ape2emp) AS nombre, AVG(importe)
    FROM personal
    JOIN comandas ON comandas.codemp = personal.codemp
    GROUP BY personal.codemp
	HAVING (SUM(importe) / COUNT(comandas.codemp) > SUM(importe));
END $$
DELIMITER ;
CALL p6();

SELECT * FROM personal;
SELECT * FROM comandas;













