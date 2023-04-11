USE empresaclase;

SELECT departamentos.numde, departamentos.nomde, COUNT(departamentos.numde), COUNT(empleados.numde)
FROM departamentos
RIGHT JOIN empleados ON empleados.numde = departamentos.numde
GROUP BY numde;

SELECT nomde, nomem
FROM departamentos
LEFT JOIN dirigir ON dirigir.numempdirec = empleados.numem
LEFT JOIN empleados ON empleados.numde = departamentos.numde;

-- 3
USE `GBDturRural2015`;

SELECT reservas.codreserva, codcasa, feciniestancia, numdiasestancia, importedevol
FROM reservas
LEFT JOIN devoluciones ON devoluciones.codreserva = reservas.codreserva
WHERE YEAR(fecreserva) = 2013;

-- 4
SELECT codzona, nomcasa, COUNT(*), COUNT(reservas.codreserva)
FROM casas
LEFT JOIN reservas ON reservas.codcasa = casas.codcasa
JOIN zonas ON casas.codzona = zonas.numzona
	WHERE zonas.numzona = 1
GROUP BY casas.codcasa;

-- 5
SELECT nomzona, nomcasa
FROM zonas
LEFT JOIN casas ON casas.codzona = zonas.numzona;

-- 6



SELECT * FROM empleados;
SELECT * FROM departamentos;
SELECT * FROM reservas;














