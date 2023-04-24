
/*
CREATE VIEW listin
	(nombre, extension) 
AS
	SELECT CONCAT()
*/

SELECT refart, nomart, preciobase, precioventa, codcat
FROM articulos
WHERE refart NOT IN
	(SELECT catalogos.refart
    FROM catalogospromos JOIN promociones ON catalogospromos.codpromo = promociones.codpromo
    WHERE CURDATE() BETWEEN promociones.fecinipromo
		AND DATE_ADD(promociones.fecinipromo, INTERVAL promociones.duracionpromo DAY)    
    );


SELECT * FROM ventapromoscompleta.promociones;



















