

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

IMPORTANTE: **AND** tiene prioridad sobre **OR**


# Tema 6

Prepara una rutina(procedimiento | funcion)

que muestre -> procedimiento

que devuelva (función | procedimiento)

1 valor -> función
  + de un valor -> procedimiento


















