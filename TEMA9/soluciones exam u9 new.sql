/* EJER 1 */
drop trigger if exists pregDifInsercion;
delimiter $$
create trigger pregDifInsercion
	before insert on preguntas
for each row
begin
	if (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		signal sqlstate '45000' set message_text = 'la pregunta ya existe';
    end;
    end if;

end $$

drop trigger if exists pregDifModificacion $$

create trigger pregDifModificacion
	before update on preguntas
for each row
begin
	if old.textopreg <> new.textopreg 
		and (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		set new.textopreg = old.textopreg;
		signal sqlstate '01000' set message_text = 'la pregunta ya existe, por lo que no se modificará';
    end;
    end if;

end $$
delimiter ;

/* EJER 2 */
/* APARTADO A */
/**
PREVIAMENTE HACEMOS UNA PRUEBA:
select nommateria, cursomateria, count(distinct codtest)
from materias join matriculas on materias.codmateria = matriculas.codmateria
	join alumnos on matriculas.numexped = alumnos.numexped
		join respuestas on alumnos.numexped = respuestas.numexped
group by nommateria, cursomateria
having count(distinct codtest) > 10;

TAL COMO ESTÁ ESTE SELECT, SI LO PONEMOS ASÍ EN EL UPDATE, SUBIRÍA LA NOTA A TODOS LOS ALUMNOS EN TODAS LAS MATERIAS MATRICULADAS QUE HAYAN HECHO MAS DE 10 TEST EN ALGUNA MATERIA,
ESO NO ES LO QUE QUEREMOS, YA QUE SOLO SE LE DEBE SUBIR NOTA EN LA MATERIA EN LA QUE HAYA HECHO MÁS DE 10 TESTS.
POR ELLO SERÍA:
*/
drop procedure if exists incrementaNotas;
delimiter $$
create procedure incrementaNotas()
begin
	update matriculas
	set nota = nota + 1
	--  select codmateria, nota
	--  from matriculas
	where numexped in (select numexped
					   from respuestas
                       where respuestas.codmateria = matriculas.codmateria
					   group by numexped
					   having count(distinct codtest) >= 10); -- para probar he usado >= 2);
end $$
delimiter ;

/* APARTADO B */

drop event if exists subirNotas;
create event subirNotas
on schedule
	every 1 year
    -- starts '2023/6/20'
    starts curdate() + interval 1 day
    ends '2023/6/20' + interval 10 year
do
	call incrementaNotas();

/* EJER 3 */
drop trigger if exists maxNotaActualiza;
delimiter $$
create trigger maxNotaActualiza
	before insert on matriculas
for each row
begin
	if old.nota <> new.nota and new.nota > 10 then
    begin
		set new.nota = 10;
        signal sqlstate '01000' set message_text = 'Se asignará una nota de 10 ya que la nota no puede ser superior a 10';
    end;
    end if;
end $$

delimiter ;

/* EJER 4 */
/*
El nombre de usuario no debe comenzar por números y debe contener mayúsculas, 
minúsculas, números y alguno e los siguientes caracteres especiales: =,_,?,!.
El email debe contener una @, y debe terminar con un punto seguido de 2 o 3 caracteres desde 
la ‘a’ a la ‘z’.
El teléfono debe comenzar por 6, 7 o 9 y debe estar formado por 3 grupos de 3 números separados por un espacio 
en blanco.
*/                   
-- Vamos a comprobar nuestros patrones mediante sentencias select:
-- Apartado a:
select  numexped, password
from alumnos
-- where password rlike '.{6}.*' and password rlike '^[^0-9]' and password  rlike '[a-z]+' 
-- 	and password rlike '[0-9]+' and password  rlike '[=_?!]+';
where password  rlike '.{6,}' and password rlike '^[^0-9]([a-z])+([0-9])+([=_?!])+'
order by numexped;

select numexped, password
from alumnos
where password rlike '^[^0-9]([a-z]+)([0-9]+)([=_?!]+)(.{6}.*)'
order by numexped;

-- Apartado b:
select *
from alumnos
where -- email rlike '@' and email rlike '([.][a-z]{2,3})$'; 
			-- email rlike '@' and email rlike '([.][a-z]{2,3})$|([.][a-z]{3})$';
			 -- email rlike '@.*([.][a-z]{2,3})$';
             email rlike ".+@.+([.][a-z]{2,3})$";

-- Apartado c:                   
select *
from alumnos
where telefono rlike '^[679][0-9]{2} [0-9]{3} [0-9]{3}';

-- Ahora hacemos lo que nos pide realmente el enunciado:

drop trigger if exists insercionAlumnado;
delimiter $$
create trigger insercionAlumnado
	before insert on alumnado
for each row
begin
	if /*(new.nomuser not rlike '.{6}.*' or new.nomuser not rlike '^[^0-9]' or new.nomuser not rlike '[a-z]+' 
			or new.nomuser not rlike '[0-9]+' or new.nomuser not rlike '[=_?!]+')*/
		new.password not rlike '^[^0-9]([a-z]+)([=_?!]+)([0-9]+).{3,}' or
		new.email not rlike '@.*([.][a-z]{2,3})$' or
        new.telefono rlike '^[679][0-9]{2} [0-9]{3} [0-9]{3}'
        then
    begin
		set new.nota = 10;
        signal sqlstate '45000' set message_text = 'Los datos del alumno/a no cumplen los requisitos';
    end;
    end if;
end $$

delimiter ;

/* EJER 5 */
drop trigger if exists pregDifInsercion;
delimiter $$
create trigger pregDifInsercion
	before insert on preguntas
for each row
begin
	if (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		signal sqlstate '45000' set message_text = 'la pregunta ya existe';
    end;
    end if;
	if new.resa = new.resb or new.resb = new.resc or new.resa = new.resc then
	begin
		signal sqlstate '45000' set message_text = 'No puede haber dos respuestas iguales en una pregunta';
    end;
    end if;
end $$

drop trigger if exists pregDifModificacion $$

create trigger pregDifModificacion
	before update on preguntas
for each row
begin
	if old.textopreg <> new.textopreg 
		and (select count(*) from preguntas where codtest = new.codtest and textopreg = new.textopreg) > 0 then
	begin
		set new.textopreg = old.textopreg;
		signal sqlstate '01000' set message_text = 'la pregunta ya existe, por lo que no se modificará. No se ha ejecutado la inserción';
    end;
    end if;
	if (new.resa <> old.resa or new.resb <> old.resb or new.resc <> old.resc) and 
		(new.resa = new.resb or new.resb = new.resc or new.resa = new.resc) then
	begin
		signal sqlstate '45000' set message_text = 'No puede haber dos respuestas iguales en una pregunta. No se ha ejecutado la modificación';
    end;
    end if;

end $$
delimiter ;


