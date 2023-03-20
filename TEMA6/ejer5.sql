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
SELECT descripcion FROM productos
INNER JOIN categorias ON categorias.codcategoria = productos.codproducto
WHERE 


SELECT * FROM categorias; 
SELECT * FROM productos;




























