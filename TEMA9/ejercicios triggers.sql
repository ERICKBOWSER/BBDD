/* Ejercicios con BD empresaclase */
use empresaclase;
-- EJER 1
delimiter $$
drop trigger if exists compruebaedad $$
create trigger compruebaedad
	before insert on empleados
for each row
begin
	-- if date_sub(curdate(), interval 16 year) < new.fecnaem then
    if date_add(new.fecnaem, interval 16 year) > curdate() then
    
		signal sqlstate '45000' set message_text = 'no se cumple la edad';
	end if;
end $$
delimiter ;
-- lo probamos:
insert into empleados
	(numem, numde, extelem, fecnaem, fecinem,salarem,
	 comisem, numhiem,nomem,ape1em,ape2em,dniem, userem, passem)
values
	(1201, 110, '342','2010/12/12', curdate(), 1000,10,
	0,'María', 'del Campo', 'Flores','10000001a','maria','1234');

-- EJER 2
delimiter $$
drop trigger if exists compruebadeptodir $$
create trigger compruebadeptodir
	before insert on dirigir
for each row
begin
	declare mensaje varchar(100);
	if (select numde from departamentos where numem = new.numempdirec) <> new.numdepto then
	begin
		set mensaje = concat('El empleado no pertenece al departamento ', new.numdepto); -- en algunas versiones de mysql de error usar concat directamente en la sentencia signal
		signal sqlstate '45000' set message_text = mensaje;
	end;
    end if;
end $$
delimiter ;
-- lo probamos:
insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values
	(....);

-- EJER 3
-- sobre ejer 1
delimiter $$
drop trigger if exists compruebaedadEditar $$
create trigger compruebaedadEditar
	before update on empleados
for each row
begin
	if old.fecnaem <> new.fecnaem -- siempre se comprueba en los triggers de update si el campo modificado es el que nos afecta
		and date_add(new.fecnaem, interval 16 year) > curdate() then
    
		signal sqlstate '45000' set message_text = 'el empleado no cumple la edad';
	end if;
end $$
delimiter ;
-- lo probamos:
update empleados
set extelem = '567'
where numem = 999;

update empleados
set fecnaem = '2007/1/1'
where numem = 999;

-- sobre ejer 2
delimiter $$
drop trigger if exists compruebadeptodirEditar $$
create trigger compruebadeptodirEditar
	before update on dirigir
for each row
begin
	declare mensaje varchar(100);
	if old.numdepto <> new.numdepto -- comprobamos si el campo modificado es el que nos afecta
		and (select numde from departamentos where numem = new.numempdirec) <> new.numdepto then
	begin
		set mensaje = concat('El empleado no pertenece al departamento ', new.numdepto);
		signal sqlstate '45000' set message_text = mensaje;
	end;
    end if;
end $$
delimiter ;
-- lo probamos:
update dirigir
set	fecfindir = curdate()
where numempdirec = 150 
	and numdepto = 121 and fecinidir = '2003/08/03';

update dirigir
set	numdepto = 111
where numempdirec = 150 
	and numdepto = 121 and fecinidir = '2003/08/03';


-- EJER 4
alter table departamentos
	add column numempleados int not null default 0
-- EJER 5
delimiter $$
drop procedure if exists calculaNumEmple $$
create procedure calculaNumEmple ()
begin
	update departamentos
    set numempleados = (select count(*)
						from empleados
						where empleados.numde = departamentos.numde);
end $$
delimiter ;
-- EJER 6
delimiter $$
create event actualizaNumeroEmpleados
on schedule
	every 1 quarter
    starts '2022/6/1'
do
	begin
		call calculaNumEmple();
    end $$
    
delimiter ;
-- EJER 7
delimiter $$
drop trigger if exists calculaNumEmpleborrado $$
create trigger calculaNumEmpleborrado 
	after delete on empleados
for each row
begin
	update departamentos
    set numempleados = (select count(*) from empleados where numde = old.numde)
    where numde = old.numde;
end $$
delimiter ;

/* BASE DE DATOS GESTION TESTS*/
use GBDgestionaTests;
-- EJER 8
alter table alumnos
	add column dnialum char(9) null;

create table profesorado
(
	codprof int, 
	nomprof varchar(60) not null, 
	ape1prof varchar(60) not null, 
	ape2prof varchar(60) null, 
	dniprof char(9) not null,
    constraint pk_profesorado primary key (codprof)
);

alter table materias
	add column codprof int,
	add constraint fk_materias_profesorado foreign key (codprof) references profesorado(codprof);

-- PROPUESTO: comprueba que un profesor no pueda matricularse de las materias que imparte:



drop trigger if exists compruebafechatest;
delimiter $$
create trigger compruebafechatest
	before insert on tests
for each row
begin
	if new.fecpublic < new.feccreacion then
		signal sqlstate '45000' set message_text = 'la fecha de publicación no puede ser anterior a la de creación';
	end if;
end $$
delimiter ;

drop trigger if exists compruebafechatestEditar;
delimiter $$
create trigger compruebafechatestEditar
	before update on tests
for each row
begin
	if (new.fecpublic <> old.fecpublic or new.feccreacion <> old.feccreacion) -- si lo que han cambiado son las fechas de creación o publicación
		and new.fecpublic < new.feccreacion then
		signal sqlstate '45000' set message_text = 'la fecha de publicación no puede ser anterior a la de creación';
	end if;
end $$
delimiter ;
-- EJER 9
drop trigger if exists compruebarepeticiontestsalumno;
delimiter $$
create trigger compruebarepeticiontestsalumno
	before insert on respuestas
for each row
begin
	if (select repetible from tests where codtest = new.codtest) = false and
	  (select count(*) from respuestas where codtest = new.codtest and numexped = new.numexped) > 0 then
		signal sqlstate '45000' set message_text = 'el test no se puede repetir';
	end if;
end $$
delimiter ;


use bdalmacen;
/* ACLARACIÓN:
En realidad vamos a trabajar con la bd "gestionpromoscompleta"
*/
-- ejer 1
delimiter $$
drop trigger if exists cantidadPositiva $$
create trigger cantidadPositiva
	before insert on pedidos
for each row
begin
	set new.cantidad = abs(new.cantidad);

end $$
delimiter ;
insert into pedidos
(codpedido, fecpedido, fecentrega,codproducto,cantidad)
values
(99999, curdate(),null,1,-10);
select * from pedidos;

-- ejer 2
delimiter $$
drop trigger if exists cantidadPositivaYCompruebaStock $$
create trigger cantidadPositivaYCompruebaStock
	before insert on pedidos
for each row
begin
	set new.cantidad = abs(new.cantidad);

	if (select stock from productos where codproducto = new.codproducto) < new.cantidad then
		signal sqlstate '45000' set message_text = 'no hay suficiente stock para este pedido';
    end if;
end $$
delimiter ;

-- Probamos el ejer 2 sobre bdalmacen:
insert into pedidos
(codpedido, fecpedido, fecentrega,codproducto,cantidad)
values
(99999, curdate(),null,17,5); -- no hay stock suficient
select * from pedidos;

select * from productos; -- veamos el stock inicial del producto 16
insert into pedidos
(codpedido, fecpedido, fecentrega,codproducto,cantidad)
values
(99999, curdate(),null,16,5); -- si hay stock suficient
select * from pedidos;
select * from productos;

-- ejer 3
delimiter $$
drop trigger if exists actualizaStock $$
create trigger actualizaStock
	after update on productos
for each row
begin
	declare nuevopedido int;
	if old.stock <> new.stock and new.stock < 5 then
    begin
		set nuevopedido = (select max(codpedido) from pedidos) + 1;
		insert into pedidos
			(codpedido, fecpedido, fecentrega, codproducto, cantidad)
		values
			(nuevopedido, curdate(), null, new.codprudto, 5);
    end;
    end if;
end $$
delimiter ;


use empresa_clase_2016;


use ventapromoscompleta;

delimiter $$
drop trigger if exists compruebaFechaPromo $$
create trigger compruebaFechaPromo
	before insert on promociones
for each row
begin

	if exists(select count(*)
			  from promociones 
			  where new.fecinipromo between fecinipromo 
						and date_add(fecinipromo, interval duracionpromo day)
				OR 
					date_add(new.fecinipromo, interval new.duracionpromo day) between fecinipromo
						and date_add(fecinipromo, interval duracionpromo day)) then
		signal sqlstate '45000' set message_text = 'Se solapan las promociones';
	end if;

end $$
delimiter ;

insert into promociones
(codpromo,despromo,fecinipromo,duracionpromo)
values
(8, 'segunda promocion de primavera 2016',
	'2016/4/15', 45);


/* ejercicio propuesto */

/* 1. modificar la tabla articulos, añadiendo el campo stock,
que contendrá el numero de articulos que hay en la tienda */

alter table articulos
	add column stock int not null default 0;
/* 2. Actualizar la tabla artículos asgnando 10 unidades a los artículos
 pares y 7 unidades a los impares */
 
 /* probemos esto:
 select refart, right(refart,2), mod(right(refart,2),2)
from articulos;
*/
 
 update articulos
	set stock = if (mod(right(refart,2),2)=0,10,7);
/* haz que cuando se haga una venta de un artículo, se modifique
automaticamente el stock 
*/
/*Veamos a que tabla, para que operación y como afecta:
cuando se haga una venta de un artículo ==> los artículos de las ventas están en DETALLEVENTA
										==> se trata de ventas nuevas ==> INSERT
										==> ¿control de datos? ==> NO
                                        ==> modificación de otros datos cuando se haga efectiva la venta ==> SI
											==> AFTER
		por tanto, se trata de hacer un trigger AFTER INSERT ON DETALLEVENTA  
        
        VALORES new y old en un trigger before|after insert
		new ==> valores que se acaban de insertar en la tabla detalleventa 
			(new.refart, new.cant, new.codventa, new.precioventa )
        old ==> valores que tenían las columnas de la tabla detalleventa para la fila en cuestión
				antes de la insercción (en las inserciones siempre es null y no se usarán)
*/

drop trigger if exists actualizastock;
delimiter $$
create trigger actualizastock
		after insert on detalleventa
for each row
begin
		update articulos
			set stock = stock - new.cant
		where refart = new.refart;
end $$
delimiter ;
/* Comprueba también que si no hay suficiente stock no se permita la venta */
/* 
/*Veamos a que tabla, para que operación y como afecta:
cuando se haga una venta de un artículo ==> los artículos de las ventas están en DETALLEVENTA
										==> se trata de ventas nuevas ==> INSERT
										==> ¿control de datos? ==> SI
                                        ==> modificación de otros datos cuando se haga efectiva la venta ==> NO
											==> BEFORE
		por tanto, se trata de hacer un trigger BEFORE INSERT ON DETALLEVENTA  
        
        VALORES new y old en un trigger before|after insert
		new ==> valores que se acaban de insertar en la tabla detalleventa 
			(new.refart, new.cant, new.codventa, new.precioventa )
        old ==> valores que tenían las columnas de la tabla detalleventa para la fila en cuestión
				antes de la insercción (en las inserciones siempre es null y no se usarán)
*/

/*

start transaction;
		select ifnull(max(codventa),0) + 1 into @nuevaventa
        from ventas;
        
        insert into ventas
			(codventa, codcli, fecventa, codvende)
		values
			(@nuevaventa, @cliente, @fecha,@vendedor);
		insert into detalleventa
			(codventa, refart, cant, precioventa)
		values
			(@nuevaventa, 'c1_01',10,2.95), -- new.codventa = @nuevaventa; new.refart = 'c1_01'; new.cant = 10; new.precioventa=2.95
            (@nuevaventa, 'c2_02',8,3.80); -- new.codventa = @nuevaventa; new.refart = 'c2_02'; new.cant = 8; new.precioventa=3.80
	commit;
*/
drop trigger if exists compruebastock;
delimiter $$
create trigger compruebastock
		before insert on detalleventa
for each row
begin
	if (select stock from articulos where refart = new.refart) < new.cant then
    begin
		signal sqlstate '45000' set message_text = 'No se puede realizar la venta por falta de stock';
    end;
    end if;
end $$
delimiter ;

/* VAMOS A COMPROBAR SI FUNCIONA */
drop procedure if exists insertaVentaDosArticulos;
delimiter $$
create procedure insertaVentaDosArticulos
(cliente int,
 fecha date,
 vendedor int,
 articulo1 char(5),
 cantidad1 int,
 precio1 decimal(6,2),
 articulo2 char(5),
 cantidad2 int,
 precio2 decimal(6,2)
 )
 begin
	declare nuevaventa int;
    declare exit handler for sqlstate '45000'
		begin
			rollback;
        end;
	start transaction;
		select ifnull(max(codventa),0) + 1 into nuevaventa
        from ventas;
        
        insert into ventas
			(codventa, codcli, fecventa, codvende)
		values
			(nuevaventa, cliente, fecha,vendedor);
		insert into detalleventa
			(codventa, refart, cant, precioventa)
		values
			(nuevaventa, articulo1,cantidad1,precio1),
            (nuevaventa, articulo2,cantidad2,precio2);
	commit;
 end $$
 delimiter ;
 select * from ventas;
 select * from detalleventa;
 select * from articulos;
 
 call insertaVentaDosArticulos
	(1,curdate(),1,'C1_01',5,2.95,'C1_02',12,3.99); -- el articulo 'C1_02' no tiene suficiente stock
													-- se deshacen todos los cambios
call insertaVentaDosArticulos
	(1,curdate(),1,'C1_03',5,2.95,'C1_04',6,3.99); 

/* Crear la tabla pedidos:
	codpedido, fecpedido, fecentrega, codarticulo, cantidad */
drop table if exists pedidos;
create table pedidos
	(codpedido int,
	 fecpedido date not null,
     fecentrega date null,
     refart char(12),
     cantidad int,
     constraint pk_pedidos primary key (codpedido),
     constraint fk_pedidos_articulos foreign key (refart) references articulos(refart)
		on delete no action on update cascade
	);
    
/* Cuando hacemos una venta y el stock resultante es menor que 5
   genera un pedido automático de 5 unidades */
/* podemos hacer de nuevo el trigger after insert sobre detalleventa añadiendo que se haga el pedido
	pero también podemos hacerlo sobre la tabla ARTICULOS
		cuando se modifique el stock ==> UPDATE
        , si este es menor que 5 ==> ¿ES DE CONTROL DE DATOS ? ==> NO
								 ==> ¡ES DE MODIFICACIÓN DE OTROS DATOS AFECTADOS ==> SI
	por tanto es un trigger AFTER UPDATE ON ARTICULOS
    
    en los triggers update:
     old ==> valores previos a la modificación de la fila que se va a modificar en la tabla que se modifica
     new ==> valores después de la modificación de la fila que se va a modificar en la tabla que se modifica
*/
drop trigger if exists pedidoautomatico;
delimiter $$
create trigger pedidoautomatico
	after update on articulos
for each row
begin

	/*
    
    
    */
	declare nuevopedido int;
	-- solo queremos hacer el pedido automático cuando se haya modificado el stock
    -- sino añadimos "old.stock <> new.stock" haríamos un pedido automatico para cualquier modificación en la tabla artículos
    -- cuando el stock fuera menor que 5 (por ejemplo cuando modificáramos la descripción del artículo
	if new.stock<5 and old.stock <> new.stock then
	begin
		select ifnull(max(codpedido),0)+1 into nuevopedido from pedidos;
		insert into pedidos
			(codpedido, fecpedido,fecentrega, refart, cantidad)
		values
			(nuevopedido, curdate(),null, new.refart, 5);
	end;
    end if;
end $$
delimiter ;

-- probemos:
update articulos
	set stock = 3
where refart = 'C2_01';
 SELECT * FROM pedidos;

