
/*
Cuando un proyecto finaliza, se le pondrá la fecha de fin de proyecto. En ese momento 
queremos que de forma automática se anoten  las gratificaciones a los técnicos que han 
trabajado en dicho proyecto cuando corresponda (si el proyecto termina en el tiempo 
previsto).
TABLA ⇒ proyectos
OPERACIÓN ⇒ UPDATE
TIPO ⇒ AFTER

*/
-- P1
DELIMITER $$
CREATE TRIGGER g2_p1 AFTER UPDATE on proyectos
FOR EACH ROW
	BEGIN
		-- Comprobamos si el proyecto ya ha finalizado
		IF NEW.fecfinproy IS NOT NULL AND OLD.fecfinproy IS NULL THEN
			NEW.fecfinproy = CURDATE();
		
            IF DATE_ADD(NEW.feciniproy, INTERVAL NEW.duracionprevista day) -- Comprobamos si el trabajo se a terminado en el tiempo previsto
				>= NEW.fecfinproy THEN
				BEGIN
					UPDATE tecnicosenproyectos -- Actualizamos la finalización del proyecto para los trabajadores implicados
						SET fecfintrabajo = NEW.fecfinproy -- dado que ya actualizamos la fecha, establecemos la misma aquí
					WHERE numproyecto = NEW.numproyecto AND fecfintrabajo IS NULL; -- Comprobamos que el numero de proyecto es el mismo y que la fecha sea NULL

					INSERT INTO gratificaciones 
						(numproyecto, numtecnico, tiempoenproyecto, gratifTotal)
                        -- Pasamos los datos
                        -- IMPORTANTE: en el DATEDIFF() primero va la fecha más grande
						VALUES (SELECT numproyecto, numtec, DATEDIFF(fecfintrabajo, fecinitrabajo),
							DATEDIFF(fecfintrabajo, fecinitrabajo) * NEW.gratifPorDia
								FROM tecnicosenproyectos
                                WHERE numproyecto = NEW numproyecto);
				 END;
			END IF;         
		 END IF;
    END $$
DELIMITER ;


/*
Se nos ha pedido que si un proyecto ya ha comenzado (la fecha de inicio de proyecto no 
tiene valor null) no se permita hacer ninguna modificación sobre los datos del proyecto.
TABLA ⇒ proyectos
OPERACIÓN ⇒ UPDATE
TIPO ⇒ BEFORE
*/

-- P2
DELIMITER $$
CREATE TRIGGER g2_p1 BEFORE UPDATE ON proyectos
FOR EACH ROW
	BEGIN
		IF OLD.feciniproy IS NOT NULL AND NEW.feciniproy > OLD.feciniproy THEN             
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede realizar modificaciones';
		END IF;
	END $$
DELIMITER ;
























