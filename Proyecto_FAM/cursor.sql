
/* tabla para obtener el ranking de las 5 recetas más usadas en la que cada mes se 
insertan las recetas más usadas de forma que se podra visualizar las tendencias a 
lo largo del tiempo y en un futuro implementar un sistema de correos para los clientes
*/
drop table if exists estadisticaMensualRecetasMasUsadas;
create table if not exists estadisticaMensualRecetasMasUsadas(
	mes int not null,
	anno int not null,
	receta int not null,
	cantidad int not null,
	nombre varchar(100) not null,
constraint pk_mes_anno_receta primary key (mes,anno,receta)
) ;

SELECT * FROM estadisticaMensualRecetasMasUsadas;

/*
Para el cursor hemos añadido una tabla nueva que servirá como estadistica, con los 
datos almacenados se podrá consultar las recetas más usadas por meses, por año, ...etc. 
*/

DELIMITER //

DROP PROCEDURE IF EXISTS cincoRecetasMasUsadas//
-- Creamos el procedimiento
CREATE PROCEDURE cincoRecetasMasUsadas() 
BEGIN

  DECLARE var_total int;
  DECLARE var_codigo int;
  DECLARE var_nombre VARCHAR(100);
  DECLARE fin integer DEFAULT 0;

-- Declaramos el cursor 
  DECLARE cursor1 CURSOR FOR 
		-- Sentencia para obtener la cuenta de las 5 recetas más usadas
		 SELECT count(*), recetas.codReceta, recetas.nombreReceta
			FROM RECETAS -- Recetas de cada plato
			JOIN PLATOS
			ON PLATOS.codReceta = recetas.codReceta -- Para poder llegar a menus 
			join menus
			on platos.codMenuDiario = menus.codMenuDiario -- 
			group by recetas.codReceta -- Agrupamos por recetas para saber el número de veces que se ha repetido en las recetas
			order by count(*) DESC LIMIT 5;
	
    -- Añadimos un control de excepciones para cuando llegue al final del cursor 
    -- CONTINUE ya que queremos que cuando llegue a esta excepción continue
    -- con el SET establecemos el valor de la variable que posteriormente usaremos en un bucle
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

  OPEN cursor1; -- Abrimos el cursor

-- Iniciar el bucle WHILE
    WHILE fin = 0 DO -- Se ejecuta hasta que llegue a la excepción y su valor cambie a 1
		-- con FETCH nos posicionamos en la siguiente fil, y le añadimos los datos del insert a la tabla que creamos antes
         FETCH cursor1 INTO var_total, var_codigo, var_nombre;
        
        insert estadisticaMensualRecetasMasUsadas
			SET mes=month(curdate()), 
            anno=year(curdate()), 
            receta=var_codigo, 
            cantidad=var_total, 
            nombre=var_nombre;
		
        -- Hacemos un select para mostrar los datos de las filas        
		SELECT * FROM estadisticaMensualRecetasMasUsadas where mes=month(curdate()) and anno=year(curdate()) order by cantidad desc;				

END WHILE;

  CLOSE cursor1;

END//
DELIMITER ;

call cincoRecetasMasUsadas();

SELECT * FROM recetas;

DELIMITER //

-- Evento para llamar al cursor para añadir las recetas más usadas en ese mes

DELIMITER $$
CREATE EVENT addRecetasMasUsadas
ON SCHEDULE EVERY 1 month STARTS '2023-01-01'
DO
BEGIN
 CALL cincoRecetasMasUsadas();
END //

DELIMITER ;





























