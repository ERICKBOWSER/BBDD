DELIMITER //
CREATE FUNCTION devExtension(empleado INT)
RETURNS CHAR(3)
DETERMINISTIC
BEGIN
	RETURN
		(SELECT extelem 
        FROM empleados
		WHERE numem = empleado
        );        
END $$
DELIMITER ;

SELECT devExtension();