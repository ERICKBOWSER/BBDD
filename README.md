

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
> Modifica la columna y nos permite modificar el tipo.

![image](https://user-images.githubusercontent.com/92431188/216872445-f10a24eb-a2fe-4234-86f2-1e8821fced20.png)


DROP PRIMARY KEY
> Para borrar la PK

AFTER nomTabla
> Para que al modificar alguna de las tablas, se agregue en la posición que especifiquemos.


TINYINT
> Es igual a INT(1) > 1 byte[-128, 127] UNSIGNED

UNSIGNED
> Hace que no se admitan números negativos.
> No afecta al número de bits que se usa.

AUTO_INCREMENT
> Añade automáticamente valores numéricos.

UNIQUE
> NO permite que un dato se vuelva a repetir

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
## Tipos de restricciones de las FK5

ON DELETE NO ACTION ON UPDATE CASCADE
> Esta de forma predeterminada.

Tipos:
* NO ACTION / RESTRICT
* * Especifica que si se intenta borrar el dato no realice ninguna acción en este

* CASCADE
* * Si se realiza alguna acción se modifican todos los datos en cascada.

* SET NULL
* * Si se realiza alguna acción establece los valores en NULL.

* SET DEFAULT
* * Cambia todos los valores en los datos por defecto. Hay que definir un valor por defecto para esto.


















