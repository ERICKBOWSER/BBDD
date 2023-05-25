-- 1

DELIMITER $$
DROP TRIGGER IF EXISTS examen_p1 $$
CREATE TRIGGER examen_p1
	BEFORE UPDATE ON preguntas
FOR EACH ROW
BEGIN
	IF(OLD.textopreg <> NULL AND OLD.textopreg <> NEW.textopreg) THEN
    BEGIN
		SET NEW.textopreg = NEW.textopreg;
	END ;
	ELSE
		SIGNAL SQLSTATE '45000' SET message_text = "No se puede añadir el texto porque ya tiene datos";
    END IF;
END $$
DELIMITER ;

UPDATE preguntas
	SET textopreg = "10"
    WHERE codtest = 1;

SELECT * FROM preguntas;

-- 2
CREATE EVENT exam_p2
ON SCHEDULE
	EVERY 1 YEAR
    STARTS '2023/06/20'
DO
BEGIN
	CALL incrementaNotas();
END $$

DELIMITER $$
CREATE PROCEDURE exam_p2_notas
	(expediente CHAR, nota INT, codigo INT)
BEGIN
	INSERT INTO matriculas VALUES (expediente, codigo, nota);
END ;
DELIMITER ;


-- 3
DELIMITER $$
CREATE TRIGGER exam_p3
	BEFORE UPDATE ON matriculas
FOR EACH ROW
BEGIN
	SET NEW.nota = ABS(NEW.nota);
    IF NEW.nota < 10 THENS
    BEGIN
		SET OLD.nota = NEW.nota;
	END ;
	ELSE IF NEW.nota > 10 THEN
    BEGIN
		SET NEW.nota = OLD.nota;
	END ;
	ELSE
    BEGIN
		SIGNAL SQLSTATE '45000' SET message_text = "La nota introducida no es correcta.";
	END ;
	END IF;
END ;
DELIMITER ;

SELECT * FROM alumnos;

SELECT password FROM alumnos
WHERE REGEXP_LIKE(password, '^[0-9][......][a-zA-Z][0-9]');

SELECT email FROM alumnos
WHERE REGEXP_LIKE(email, '[a-zA-Z]+[@].$[...$][a-z]');

-- 5
DELIMITER $$
CREATE TRIGGER exam_p5
	BEFORE INSERT ON preguntas
FOR EACH ROW
BEGIN
	CASE
	WHEN NEW.resa <> OLD.resb OR NEW.resa <> OLD.resc 
		THEN SET OLD.resa = NEW.resa
	WHEN NEW.resb <> OLD.resa OR NEW.resb <> OLD.resc 
		THEN SET OLD.resb = NEW.resb
    ELSE OLD.resc = NEW.resc
	END;
END ;
DELIMITER ;
























