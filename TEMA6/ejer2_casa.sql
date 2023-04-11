USE empresaclase;

-- 3
SELECT * FROM empleados;
SELECT * FROM departamentos;
SELECT * FROM dirigir;
SELECT * FROM  centros;

-- 4 
SELECT extelem, nomde, nomem, ape1em
	FROM empleados
    INNER JOIN departamentos ON departamentos.numde = empleados.numde
    WHERE empleados.nomem = TRIM("Juan") AND empleados.ape1em = "López";


-- 5
SELECT CONCAT_WS(" ", nomem, ape1em, ape2em) AS "Nombre completo", nomde
	FROM empleados
    JOIN departamentos ON departamentos.numde = empleados.numde
		WHERE nomde = "Personal" OR nomde = "Finanzas";
        
-- 6
SELECT nomem, dirigir.fecfindir, nomde  FROM empleados 
	JOIN departamentos ON departamentos.numde = empleados.numde
    JOIN dirigir ON dirigir.numempdirec = empleados.numem
		WHERE nomde = "Personal" AND fecinidir <= CURDATE() AND (dirigir.fecfindir IS NULL OR fecfindir >= CURDATE());
    
-- 7
SELECT nomde, presude, nomce
	FROM departamentos
    JOIN centros ON centros.numce = departamentos.numce
		WHERE TRIM(centros.nomce) = "SEDE CENTRAL";

-- 8
SELECT nomce, presude FROM centros 
	JOIN departamentos ON departamentos.numce = centros.numce
		WHERE presude BETWEEN 100000 AND 150000;

-- 9
SELECT DISTINCT extelem, nomde
	FROM empleados
    JOIN departamentos ON departamentos.numde = empleados.numde
		WHERE nomde = "Finanzas";


-- 10 nani?
DROP PROCEDURE IF EXISTS act2_ejer10;
DELIMITER //
CREATE PROCEDURE act2_ejer10(INOUT nombreDepto VARCHAR(60))
BEGIN
	SELECT CONCAT(empleados.ape1em, IFNULL(CONCAT(" ", empleados.ape2em), ''), ',', empleados.nomem) INTO nombreDepto
	FROM departamentos JOIN dirigir
		ON departamentos.numde = dirigir.numdepto
	JOIN empleados
		ON empleados.numem = dirigir.numempdirec
    WHERE departamentos.nomde = nombreDepto
		AND IFNULL(dirigir.fecfindir, CURDATE()) >= CURDATE();
                
END $$
DELIMITER ;

CALL act2_ejer10("Publicidad");

-- 13 // NO FUNCIONA
DROP PROCEDURE IF EXISTS act2_ejer13;
DELIMITER //
CREATE PROCEDURE act2_ejer13
	(IN director INT(20))
BEGIN
	SELECT nomem
	FROM empleados
    JOIN departamentos ON departamentos.numde = empleados.numde
    JOIN dirigir ON dirigir.numdepto = departamentos.numde
		WHERE director = numdepto AND numempdirec = numem;
END //
DELIMITER ;

CALL act2_ejer13(250);

-- 14 
DELIMITER //
CREATE PROCEDURE act2_ejer14
	(IN centro VARCHAR(10))
BEGIN
	SELECT CONCAT_WS(" ", nomem, ape1em, ape2em) AS "Nombre completo", nomde
	FROM empleados
    JOIN departamentos ON departamentos.numde = empleados.numde
		WHERE nomde = centro;
END //
DELIMITER ; 

CALL act2_ejer14("Finanzas");

-- 15 -- NO FUNCIONA
DROP PROCEDURE IF EXISTS act2_ejer15;
DELIMITER $$
CREATE PROCEDURE act2_ejer15
	(IN fecinicio DATE, IN fecfin DATE)
BEGIN
	SELECT nomem, dirigir.fecfindir, nomde  FROM empleados 
	JOIN departamentos ON departamentos.numde = empleados.numde
    JOIN dirigir ON dirigir.numempdirec = empleados.numem
		WHERE nomde = "Personal" AND fecfindir BETWEEN fecinicio AND fecfin;
END $$
DELIMITER ;

CALL act2_ejer15('1999-06-10', '2012-03-10');

SELECT * FROM departamentos;
SELECT * FROM dirigir;



























    
    
    
