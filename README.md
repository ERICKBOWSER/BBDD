

# DDL - Data Definition Language

CREATE DATABASE nombreBBDD;
> Se usa para crear la BBDD.
> Es obligatorio ponerlo.

USE nombreBBDD;
> Especifica la BBDD que vamos a usar.
> Si no se coloca no se modifica ninguna BBDD.

CONSTRAINT pk_nombreTabla PRIMARY KEY(nombrePK)
> Se usa para especificar cual va a ser la clave primaria(PK).

![image](https://user-images.githubusercontent.com/92431188/216859733-f729e2f4-6bb9-450d-8c6e-e64ab8074788.png)


ALTER TABLE nombreTabla
> Se usa para modificar una tabla.
> Las modificaciones que se quieran hacer con ADD y DROP van dentro.
> No se puede modificar restricciones.

ADD COLUMN nombre TIPO
> Para añadir una nueva columna.

MODIFY COLUMN nombreColumna TIPO
> Nos permite modificar el tipo de la columna.

![image](https://user-images.githubusercontent.com/92431188/216872445-f10a24eb-a2fe-4234-86f2-1e8821fced20.png)

DROP COLUMN nombreColumna
> Para eliminar una columna, si es PK o FK, primero hay que eliminar sus relaciones.

![image](https://user-images.githubusercontent.com/92431188/217112298-1f9bb731-3e33-4734-81e4-21985dd113f0.png)

DROP PRIMARY KEY
> Para borrar la PK

![image](https://user-images.githubusercontent.com/92431188/217111611-b6960403-759c-4d61-ada8-2604e917c5a3.png)

DROP FOREIGN KEY fk_nombre
> Para borra la FK

![image](https://user-images.githubusercontent.com/92431188/217111794-eb768254-b73d-45a7-abac-74b0cc367228.png)


AFTER nomTabla
> Para que al modificar alguna de las tablas, se agregue en la posición que especifiquemos.

![image](https://user-images.githubusercontent.com/92431188/217112817-632c5e83-19ef-4e65-b606-5b7f0530e134.png)

DROP TABLE nombreTabla
> Para eliminar una tabla.

![image](https://user-images.githubusercontent.com/92431188/217112419-1ac583cd-82fb-462f-8b20-3093c51f6dcc.png)

DROP DATABASE nombreBBDD
> Para eliminar una BBDD.

![image](https://user-images.githubusercontent.com/92431188/217112565-26e16b99-938e-42d7-8ee1-17f4277210f5.png)

TINYINT
> Es igual a INT(1) > 1 byte[-128, 127] UNSIGNED

UNSIGNED
> Hace que no se admitan números negativos.
> No afecta al número de bits que se usa.

AUTO_INCREMENT
> Añade automáticamente valores numéricos.

UNIQUE
> NO permite que un dato se vuelva a repetir

![image](https://user-images.githubusercontent.com/92431188/217111988-354051fc-9006-4699-904e-f58866dffede.png)


CHAR
> Ocupa el espacio que se especifique, es fijo.

VARCHAR
> No desperdicia el espacio ya que es variable.
> Puede llegar a ocupar el espacio que se le especifique.
> Se suele usar para emails.

SET
> Permite almacenar diferentes valores y posteriormente poder usar esos datos.
> Devuelve los valores en el mismo orden en el que se han especificado.
> Puede devolver múltiples valores.

ENUM
> Puede almacenar varios valores como opciones fijas, de las cuales se pueden seleccionar varios.
> Solo puede devolver un dato.

![image](https://user-images.githubusercontent.com/92431188/216862970-a73c360a-52ba-4af5-a930-3f2e1467b636.png)

***
## Tipos de restricciones de las FK

ON DELETE NO ACTION ON UPDATE CASCADE
> Esta de forma predeterminada.

Tipos:
* NO ACTION / RESTRICT
* * Especifica que si se intenta borrar o modificar el dato no realice ninguna acción en este

* CASCADE
* * Si se realiza alguna acción se modifican todos los datos en cascada.

* SET NULL
* * Si se realiza alguna acción establece los valores en NULL.

* SET DEFAULT
* * Cambia todos los valores en los datos por defecto. Hay que definir un valor por defecto para esto.


# SENTENCE QUERY LANGUAGE (SQL)

## IMPORTANTE

Si queremos mostrar datos uno detrás de otro se usa ORDER BY.
***
No se puede colocar una comparación de agrupación dentro de un WHERE ya que los grupos todavía no están hechos.
***
El orden por defecto es ASC.
***
Las funciones de agregado (SUM, AVG, COUNT, etc) no se pueden usar en el WHERE
***
Se puede usr GROUP BY sin HAVING
***
No se puede hacer un HAVING sin un GROUP BY
***
Mientras se está realizando una manipulación en una tabla, no se puede hacer consultas de esa misma tabla

Sentencias SELECT

Clausulas:
* SELECT
* FROM
* WHERE
* GROUP BY
* HAVING
* ORDER BY

Orden de ejecución:
1.  FROM
2.  WHERE
3.  GROUP BY
4.  HAVING
5.  ORDER BY

## Operadores lógicos

=   Igual que
>   Mayor que
>=  Mayor o igual
<   Menor que
<=  Menor o igual
<>  Diferente de | Si se coloca != se lo traga, pero no es correcto usarlo.


Se ejecuta de izquierda a derecha teniendo como prioridad el **AND**

AND   Y
OR    O
NOT   NO
SOME / ANY
ALL
NOT IN

IMPORTANTE: **AND** tiene prioridad sobre **OR**

Ejemplo NOT IN: devuelve las casas que no estan reservadas

```
SELECT codcasa
FROM casas
WHERE codcasa NOT IN
  (SELECT codcasa
   FROM reservas)

```

## INNER JOIN 

Une dos tablas por un dato que tengan en común.

Código:

```
SELECT consulta
  FROM tabla1
  INNER JOIN tabla2 ON tabla1.comparar = tabla2.comparar
```

Ejemplo: en este ejemplo el dato en común que comparten es el numde que esta incluido en las dos tablas.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/230786530-cba42947-21b5-48bf-b2e0-1f217559c53a.png"> </p>


## ORDER BY

Se utiliza para especificar porque criterio se pretende ordenar los registros de una tabla.

Código:

```
SELECT consulta
  FROM tabla
  ORDER BY datoOrdenar ASC/DESC

```


## GROUP BY

Se utiliza para especificar porque criterio se puede agrupar a los registros de una tabla.

Código:

```
SELECT consulta
  FROM tabla
  GROUP BY datoAgrupar

```

Ejemplo: en este ejemplo agrupamos por la extelem todos los datos, con lo que conseguimos que los datos que se repitan solo salgan 1 vez.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/230790172-5b99d6b9-9a05-43e3-857d-69a8d81aa366.png"> </p>

## Procedimientos almacenados

Es una porción de código que se puede guardar y reutlizar. Se usa para encapsular y reutilizar código. 

Acepta parámetros para interactuar con ellos.

Código: 

```
DELIMITER $$
  CREATE PROCEDURE nombreProcedimiento (IN varEntrada TIPO, OUT, varSalida TIPO)
  BEGIN
    SELECT consulta INTO varSalida -- el resultado se almacena en la variable de salida
    FROM tabla;
  END $$ -- Si se coloca // no se crea el procedimiento
DELIMITER ;

-- Llamar al procedimiento
CALL nombreProcedimiento(valorEntradaSiExiste, @varSalidaSiExiste);

IMPORTANTE: IN se usa para los parámetros de entrada y OUT para los parámetros de salida.
IMPORTANTE: DELIMITER limita el bloque de código.
```

Ejemplo: en el que se le pasa un código de zona y nos devuelve los datos que coincidan con el.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/230955408-f29a5842-f9f1-40cf-bd6e-86ee11d803d1.png"> </p>


## Rutinas

```
Prepara una rutina(procedimiento | funcion)

  que muestre -> procedimiento

  que devuelva (función | procedimiento)

  1 valor -> función
    + de un valor -> procedimiento
```


## IMPORTANTE

Si se crea un clon es obligatorio colocar el nombre de la tabla en la consulta

***

Se puede colocar un AND dentro de un JOIN

## Funciones existentes

``CONCAT(tabla1, "que colocar entre uno y otro", tabla2, "", etc)``

* Sirve para concatenar datos
* Si se quiere separar o meter algo entre un dato y otro hay que especificarlo
* IFNULL (tabla, "contenido en caso de que sea NULL")

``CONCAT_WS("Se define antes que los datos a concatenar", tabla1, tabla2, etc)``

* Si se quiere que haya un espacio o algo entre cada dato se especifica al principio y solo 1 vez.
* No hace falta colocar IFNULL

``IFNULL("Condición a analizar", "En caso de NULL se ejecuta esto")``

``DISTINCT()``
*  No devuelve valores repetidos.
*  Hace que los valores sean únicos.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/230805948-d2e73aa2-5e4a-42d1-8370-93822ac61970.png"> </p>

``LEFT(nomColumna, número)``
* Devuelve el número de carácteres de una cadena que se especifiqué. Empezando desde la izquierda.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/231684551-98ad2866-8562-441a-825c-1b5718faf95e.png"> </p>

``SQRT(nombreColumna)``
* Devuelve la raíz cuadrada de un número.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/231687351-35b7be43-bfab-4461-9e83-e835a71e87de.png"> </p>

``MONTHNAME(fecha)``
* Devuelve el nombre del mes

``DAYNAME(fecha)``
* Devuelve el nombre del día de la semana

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/231688629-355b360b-f912-41f0-b71e-f3ecb741f2db.png"> </p>

``SUBSTRING(atributoBuscar, posición)``
* Devuelve el resto del contenido después de la posición que se especifique.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/233870192-0cd46c23-387f-4d53-82fb-a718e77019f6.png"> </p>

``ROUND(atributo, número)``
* Redondea un número a un número especifico de decimales.

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/233872396-e85c3849-9d08-42b4-bcc2-16485dd0d4a8.png"> </p>


``TIMESTAMPDIFF(unidad, fecha1, fecha2)``
* unidad: devuelve un entero del tipo que se coloque que pueden ser MONTH, YEAR, MINUTE
* fecha1: es la fecha que resta
* fecha2: es la fecha a la que se le resta

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/233876239-a74e2605-6177-4f3d-8156-a3f2c23b718d.png"> </p>

``DATEDIFF(fecha1, fecha2)``
* Devuelve el número de días de diferencia entre dos fechas.
* IMPORTANTE: no se puede usar para calcular la edad

``AVG(tabla)``
* Devuelve la media de todos los datos
* Una función de agregado NO se puede anidar como tampoco en WHERE. Ejemplo ``AVG(COUNT(tabla))``


## GROUP BY Y HAVING

### IMPORTANTE

Se puede usar GROUP BY sin HAVING
***
No se puede hacer un HAVING sin un GROUP BY
***
La consulta tiene que tener una función

```
SELECT FUNCION(aributo1), atributo2, etc
FROM tabla
GROUP BY atributo -- Indicar la columna que se va a agrupar
HAVING FUNCION(atributo1) -- Se coloca la funcion de la consulta y un comparador
```




## VISTAS

Es una consulta que se presenta como un tabla virtual a partir de un conjunto de tablas.

Tiene la misma estructura que una tabla, almacena la definición y no los datos.

Las vistas sirven para crear subesquemas 


### IMPORTANTE 

mysql no diferencia entre tabla y vistas, lo habítual es ponerle el prefijo "vista" al nombre.

***

No se pueden hacer inserciones.

***


```
CREATE VIEW vistaNombre AS
  consulta;
 
 -- Consultar
 SELECT * FROM vistaNombre;

-- Eliminar
DROP VIEW vistaNombre

-- Modificar
ALTER VIEW vistaNombre

```

### SUBCONSULTAS

Es una consulta que se encuentra dentro de otra consulta. Que se ejecutan de la última a la primera.

IMPORTANTE

Dentro de una sentencia se puede especificar hasta 16 subconsultas y dentro de una subconsulta se pueden especificar otras subconsultas.

***

<p align="center"> <img src="https://user-images.githubusercontent.com/92431188/233891022-a2232330-1943-41a6-b5a0-4c82f79cad51.png"> </p>





















































