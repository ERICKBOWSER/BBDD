
-- 1
SELECT clientes.nomcli, SUM(detalleVenta.precioventa)
FROM ventas
	INNER JOIN clientes ON clientes.codcli = ventas.codcli
	INNER JOIN detalleVenta ON detalleVenta.codventa = ventas.codventa
GROUP BY clientes.nomcli
ORDER BY detalleVenta.cant DESC;

-- 2


-- 3
SELECT AVG(precioventa), precioventa, despromo
FROM articulos
JOIN catalogospromos ON catalogospromos.refart = articulos.refart
JOIN promociones ON promociones.codpromo = catalogospromos.codpromo
WHERE YEAR(promociones.fecinipromo) = 2012;

-- 4
DROP PROCEDURE IF EXISTS sim_ex5_2;
DELIMITER $$
CREATE PROCEDURE sim_ex5_2
	()
BEGIN


END $$
DELIMITER ;






SELECT * FROM promociones;
SELECT * FROM clientes;
SELECT * FROM ventas;







