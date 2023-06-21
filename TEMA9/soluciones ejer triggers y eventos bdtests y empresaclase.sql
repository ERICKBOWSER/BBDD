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
	(1201, 110, '342','2014/12/12', curdate(), 1000,10,
	0,'María', 'del Campo', 'Flores','10000001a','maria','1234');

-- en la modificación:

delimiter $$
drop trigger if exists compruebaedadActualizacion $$
create trigger compruebaedadActualizacion
	before update on empleados
for each row
begin
	-- if date_sub(curdate(), interval 16 year) < new.fecnaem then
    if old.fecnaem <> new.fecnaem and
        (date_add(new.fecnaem, interval 16 year) > curdate()) then
    
		signal sqlstate '45000' set message_text = 'no se cumple la edad';
	end if;
end $$
delimiter ;


-- EJER 2


/*
trigger before insert on dirigir

*/



delimiter $$
drop trigger if exists compruebadeptodir $$
create trigger compruebadeptodir
	before insert on dirigir
for each row
begin
	declare mensaje varchar(100);
	if (select numde from empleados where numem = new.numempdirec) <> new.numdepto then
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
	-- call calculaNumEmple ();
    -- select * from departamentos;
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
    
deli0miter ;
-- EJER 7
delimiter $$
drop trigger if exists calculaNumEmpleborrado $$
create trigger calculaNumEmpleborrado 
	after delete on empleados
for each row
begin
	update departamentos
    -- set numempleados = (select count(*) from empleados where numde = old.numde)
    set numempleados =  numempleados -1
    where numde = old.numde;
end $$
delimiter ;

/* propuesta de mejora:
si un empleado es director de un depto en la actualidad no se podrá eliminar.
hacer el control de número de empleados en todas las operaciones de modificación de la tabla empleados
*/