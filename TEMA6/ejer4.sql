
/* Para la base de datos de turismo rural, queremos obtener las casas 
disponibles para una zona y un rango de fecha dados.*/

DROP PROCEDURE IF EXISTS act4_40;
DELIMITER $$
CREATE PROCEDURE act4_40
	(IN zona INT)
BEGIN
	SELECT codcasa
    FROM casas
    WHERE codcasa NOT IN
		(SELECT codcasa
        FROM reservas
        WHERE (fecinicio BETWEEN fechaInicio AND fechaFin)
			OR(DATE_ADD(feciniestancia, INTERVAL numdiasestancia DAY) 
            BETWEEN fechaInicio AND fechaFin)
        )
		AND codzona  = zona;
END $$
DELIMITER ;













