USE `bdalmacen`;


-- 1. Obtener todos los productos que comiencen por una letra determinada.
SELECT descripcion FROM productos
	WHERE descripcion REGEXP "^a";

/* 2 Se ha diseñado un sistema para que los proveedores puedan acceder a ciertos 
datos, la contraseña que se les da es el teléfono de la empresa al revés. Se pide 
elaborar un procedimiento almacenado que dado un proveedor obtenga su contraseña 
y la muestre en los resultados.
*/
SELECT REVERSE(telefono) as "Contraseña", telefono FROM proveedores
	WHERE codproveedor = 2;
	
/* 3 Obtener el mes previsto de entrega para los pedidos que no se han recibido 
aún y para una categoría determinada.
*/
SELECT MONTH(fecentrega) as "Mes" FROM pedidos
INNER JOIN productos ON productos.codproducto = pedidos.codproducto
INNER JOIN categorias ON categorias.codcategoria = productos.codcategoria
WHERE categorias.codcategoria = 4 AND fecentrega >= CURDATE() OR 
	pedidos.fecentrega IS NULL;

/* 4 Obtener un listado con todos los productos, ordenados por categoría, en el que 
se muestre solo las tres primeras letras de la categoría.
*/
SELECT productos.*, Nomcategoria, LEFT(categorias.Nomcategoria, 3) ,
SUBSTRING(REVERSE(categorias.Nomcategoria), 1, 3) AS prueba -- se puede usar para recorrer, pero también con otras funciones como reverse
FROM productos
INNER JOIN categorias ON categorias.codcategoria = productos.codproducto;

-- 5 Obtener el cuadrado y el cubo de los precios de los productos.
SELECT SQRT(preciounidad) AS 'Raiz cuadrada', preciounidad FROM productos;

-- 6 Devuelve la fecha del mes actual.
SELECT MONTHNAME(CURDATE());

-- 7 Para los pedidos entregados el mismo mes que el actual, obtener cuantos días 
-- hace que se entregaron.
SELECT DATEDIFF(MONTH(fecentrega), MONTH(CURDATE())) FROM pedidos;

INSERT INTO pedidos VALUES(10249, '2023-02-05 00:00:00', '2023-04-8 00:00:00', 1, 20);

-- 8 En el nombre de los productos, sustituir “tarta” por “pastel”.
SELECT REPLACE(descripcion, 'Tarta', 'Pastel') FROM productos
	WHERE descripcion LIKE '%Tarta%';

-- 9 Obtener la población del código postal de los proveedores (los primeros dos 
-- caracteres se refieren a la provincia y los tres últimos a la población).

SELECT LEFT(codpostal, 2) AS provincia, RIGHT(codpostal, 3) AS 'población'
FROM proveedores;

-- Eva
select codpostal,right(codpostal,3),
	substring(codpostal, 3,2), ciudad
from proveedores;

/* 10 Obtén el número de productos de cada categoría, haz que el nombre de la 
categoría se muestre en mayúsculas.
*/
SELECT UPPER(productos.descripcion), COUNT(*) AS contador
FROM productos
JOIN categorias ON categorias.codcategoria = productos.codcategoria
GROUP BY categorias.Nomcategoria;

/* 11 Obtén un listado de productos por categoría y dentro de cada categoría del 
nombre de producto más corto al más largo.
*/
SELECT Nomcategoria
FROM categorias
ORDER BY length(Nomcategoria) ASC;

/* 12 Asegúrate de que los nombres de los productos no tengan espacios en blanco al 
principio o al final de dicho nombre.
*/
SELECT TRIM(descripcion) FROM productos;

UPDATE productos
SET descripcion = TRIM(descripcion);






SELECT * FROM categorias; 
SELECT * FROM productos;
SELECT * FROM pedidos;
SELECT * FROM proveedores;




























