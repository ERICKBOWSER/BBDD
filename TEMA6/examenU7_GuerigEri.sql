
-- P.1
SELECT tests.codtest, materias.nommateria
FROM tests 
WHERE TIMESTAMPDIFF(MONTH, feccreacion, fecpublic) + INTERVAL 3 MONTH;



-- P.2
DROP FUNCTION IF EXISTS exam7_2;
DELIMITER $$
CREATE FUNCTION exam7_2
	(codigo INT)
    RETURNS VARCHAR(100)
LANGUAGE SQL
DETERMINISTIC
BEGIN
	RETURN(SELECT CONCAT(LEFT(nomalum, 1), 
		LEFT(REVERSE(nomalum), 1), 
		SUBSTRING(ape1alum, LENGTH(ape1alum) / 2 - 1, 3),
		MONTH(fecnacim),
		"micentro.es")
	FROM alumnos
	WHERE numexped = codigo
    );
END $$
DELIMITER ;

SELECT exam7_2(2);

-- 3
/*
Dado el número de expediente de un alumno o alumna, obtener el número 
de respuestas acertadas e n cada test y cada repetición. Queremos 
descartar aquellos tests y o repeticiones en los que el alumno haya 
contestado menos de 4 preguntas acertadamente
*/
SELECT alumnos.nomalum, COUNT(respuestas.numpreg), 
	respuestas.numrepeticion
FROM tests
JOIN preguntas ON preguntas.codtest = tests.codtest
JOIN respuestas ON respuestas.numpreg = preguntas.numpreg
JOIN alumnos ON alumnos.numexped = respuestas.numexped
WHERE respuestas.numexped = 1
GROUP BY alumnos.nomalum
HAVING COUNT(respuestas.numpreg) > 4;

-- 4

SELECT nommateria, cursomateria, COUNT(codtest)
FROM materias
JOIN tests ON tests.codmateria = materias.codmateria
GROUP BY nommatera
HAVING COUNT(tests.codtest);

-- 5
SELECT numexped, 
	CONCAT(alumnos.nomalum, " ", ape1alum, IFNULL(ape2alum, ""))
FROM alumnos
JOIN respuestas ON respuestas.numexped = alumnos.numexped
JOIN matriculas ON matriculas.numexped = alumnos.numexped;

-- 6
CREATE VIEW vistaExam7_6 AS
	SELECT materias.codmateria, materias.nommateria,
		tests.codtest, tests.descrip, respuestas.respuesta,
        preguntas.numpreg, tests.repetible
	FROM tests
    JOIN materias ON materias.codmateria = tests.codmateria
    JOIN preguntas ON preguntas.codtest = tests.codtest
	JOIN respuestas ON respuestas.numpreg = preguntas.numpreg;

-- 7
DROP FUNCTION IF EXISTS exam7_7;
DELIMITER $$
CREATE FUNCTION exam7_7
	(alumno INT, materia INT)
    RETURNS INT(10)
    DETERMINISTIC
BEGIN
	RETURN(
		SELECT AVG(respuestas.respuesta, preguntas.numpreg) AS nota
		FROM matriculas
		JOIN materias ON materias.codmateria = matriculas.codmateria
		JOIN alumnos ON alumnos.numexped = matriculas.numexped
		JOIN respuestas ON respuestas.numexped = alumnos.numexped
		JOIN preguntas ON preguntas.numpreg = respuestas.numpreg
		WHERE alumnos.numexped = alumno AND matriculas.codmateria = materia
    );
END $$
DELIMITER ;

SELECT exam7_7(1, 1);

SELECT * FROM respuestas;
SELECT * FROM tests;
SELECT * FROM matriculas;
-- SELECT * FROM alumnos























