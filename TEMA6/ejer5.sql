USE `bdalmacen`;

-- 1

SELECT descripcion FROM productos
	WHERE descripcion REGEXP "^a";

-- 2
SELECT REVERSE(telefono) as "Contraseña", telefono FROM proveedores
	WHERE codproveedor = 2;
	
-- 3
SELECT MONTH(fecentrega) as "Mes" FROM pedidos
INNER JOIN productos ON productos.codproducto = pedidos.codproducto
INNER JOIN categorias ON categorias.codcategoria = productos.codcategoria
WHERE categorias.codcategoria = 4 AND fecentrega > CURDATE();

-- 4
SELECT productos.*, LEFT(categorias.Nomcategoria, 3) FROM productos
INNER JOIN categorias ON categorias.codcategoria = productos.codproducto;

-- 5
SELECT SQRT(preciounidad) AS 'Raiz cuadrada', preciounidad FROM productos;

-- 6
SELECT MONTHNAME(CURDATE());

-- 7
SELECT DATEDIFF(MONTH(fecentrega), MONTH(CURDATE())) FROM pedidos;

INSERT INTO pedidos VALUES(10249, '2023-02-05 00:00:00', '2023-04-8 00:00:00', 1, 20);

-- 8
SELECT REPLACE(descripcion, 'Tarta', 'Pastel') FROM productos
	WHERE descripcion LIKE '%Tarta%';



SELECT * FROM categorias; 
SELECT * FROM productos;
SELECT * FROM pedidos;




























