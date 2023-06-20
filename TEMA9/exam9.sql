

/*
tabla: preguntas
operacion: INSERT
tipo: BEFORE
*/
-- P1
DELIMITER $$
CREATE TRIGGER exam9_p1_1 BEFORE INSERT
ON preguntas
FOR EACH ROW
	BEGIN
		-- Como no queremos que se repitan hacemos un conteo de todas las filas
		IF (SELECT COUNT(*) FROM preguntas WHERE codtest = NEW.codtest 
			AND textopreg = NEW.textopreg) > 0 THEN
        BEGIN	
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede añadir';
		END;
        END IF;
	END $$
DELIMITER ;

/*
tabla: tests
operacion: UPDATE
tipo: AFTER
*/

DELIMITER $$
CREATE TRIGGER exam9_p1_2 BEFORE UPDATE
ON preguntas
FOR EACH ROW
	BEGIN
		IF OLD.textopreg <> NEW.textopreg AND -- preguntar
			(SELECT COUNT(*) FROM preguntas WHERE codtest = NEW.codtest 
			AND textopreg = NEW.textopreg) > 0 THEN
		BEGIN	
			SET NEW.textopreg = OLD.textopreg;           
            
            SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'No se puede';
        END ;
        END IF;
    END $$
DELIMITER ;


-- P2
DROP EVENT IF EXISTS exam9_p2;
CREATE EVENT exam9_p2
ON SCHEDULE
	EVERY 1 YEAR
    STARTS '2023/06/20'
    ENDS '2023/06/20' + INTERVAL 10 YEAR
DO
	CALL incrementaNotas();

-- P3
/*
tabla: matriculas
TIPO: BEFORE
OPERACION: UPDATE
*/
DROP TRIGGER exam9_p3;
DELIMITER $$
CREATE TRIGGER exam9_p3 BEFORE UPDATE
ON matriculas
FOR EACH ROW
BEGIN
	IF OLD.nota <> NEW.nota AND NEW.nota > 10 THEN
    BEGIN
		SET NEW.nota = 10; -- No se permiten actualizaciones de OLD en el UPDATE
        
        SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Se le asignara un 10';
	END;
    END IF;
END $$
DELIMITER ;

UPDATE matriculas
	SET nota = 15
    WHERE codmateria = 1;
SELECT * FROM matriculas;

-- P5
/*
tabla: preguntas
tipo: BEFORE
operacion: INSERT
*/
DELIMITER $$
CREATE TRIGGER exam9_p5 BEFORE INSERT
ON preguntas
FOR EACH ROW
BEGIN
	IF (NEW.resa <> OLD.resa OR NEW.resb <> OLD.resb OR NEW.resc <> OLD.resc)
		AND (NEW.resa <> NEW.resb OR NEW.resb <> NEW.resc OR NEW.resa = NEW.resc) THEN
    BEGIN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No puede haber dos preguntar iguales";
    END ;
	END IF;
END $$
DELIMITER ;










