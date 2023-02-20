USE empresaclase;

-- Ejer 3
INSERT INTO departamentos (numde, numce, presude, depende, nomde)
	VALUES (1, 20, 15000, 110, "Publicidad");

INSERT INTO empleados (numem, numde, extelem, fecnaem, fecinem, salarem, comisem, numhiem, nomem, ape1em)
	VALUES(1, 1, 930, "1967/6/12", CURDATE(), 2000, 150, 2, "Rosa", "del Campo Florido");

INSERT INTO dirigir (numdepto, numempdirec, fecinidir, fecfindir, tipodir)
	VALUES(1, 1, CURDATE(), CURDATE() + 365, "P");

-- Ejer 4
UPDATE departamentos
	SET numce = 10
	WHERE nomce = "Sede central";
	
-- Ejer 5
INSERT INTO empleados (numem, numde, extelem, fecnaem, fecinem, salarem, comisem, numhiem, nomem, ape1em, ape2em)
	VALUES(2, 1, 940, "1972/2/12", CURDATE(), 1400, NULL, 1, "Pedro", "González", "Sánchez"),
			(3, 1, 940, "1975/9/25", CURDATE(), 1400, NULL, 0, "Juan", "Torres", "Campos");

-- Ejer 6
DELETE FROM empleados
	WHERE numem = 3;

-- Ejer 7
UPDATE empleados
	SET numde = 120,
		salarem = salarem * 1.1,
        extelem = 910
    WHERE (nomem = "Dorinda" AND ape1em = "Lara") -- Al comparar se coloca parentesis
		OR (nomem = "Pepito" AND ape1em = "Pérez");

-- Primero se hacen las operaciones AND Y luego las OR 


SELECT * FROM departamentos;

SELECT * FROM centros;

SELECT * FROM empleados;

SELECT * FROM dirigir;






























