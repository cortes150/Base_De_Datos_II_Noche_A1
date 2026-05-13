USE portal_proyectos_db;

-- 1. mostrar los proyectos ganadores con innovacion mayor a 90, junto al nombre del docente responsable, ordenados del mas innovador al menos innovador 
select p.titulo as proyecto, p.nivel_innovacion, d.nombre as nombre_docente, d.apellido as apellido_docente
from proyecto p
join docente d on p.id_docente = d.id_docente
where p.estado = 'ganador' and p.nivel_innovacion > 90
order by p.nivel_innovacion desc;
-- 2. mostrar los estudiantes que pertenecen a equipos y que ademas esten en semestres entre 5 y 8
select e.nombre, e.apellido, e.semestre, ee.id_equipo
from estudiante e
inner join equipo_estudiante ee on ee.id_estudiante = e.id_estudiante
where e.semestre between 5 and 8;
-- 3. mostrar las empresas que realizaron contactos a proyectos cuyo estado sea "ganador"
select e.nombre 
from empresa e 
inner join contacto_empresa ce on ce.id_empresa=e.id_empresa
inner join proyecto p on p.id_proyecto=ce.id_proyecto
where p.estado = "ganador";
-- 4. mostrar el promedio de innovacion por docente, pero unicamente de docentes cuyo promedio sea mayor a 90
select d.nombre, d.apellido, avg(p.nivel_innovacion) as promedio_innovacion
from docente d
join proyecto p on d.id_docente = p.id_docente
group by d.id_docente, d.nombre, d.apellido
having avg(p.nivel_innovacion) > 90;
-- 5. mostrar los proyectos que particiaparon en ferias y obtuvieron puntuacion mayor al promedio de todas las puntuaciones
select p.id_proyecto, p.titulo, pf.puntuacion
from proyecto p
join proyecto_feria pf on p.id_proyecto = pf.id_proyecto
where pf.puntuacion > (select avg(puntuacion) from proyecto_feria);
-- 6. mostrar las carreras que tienen mas de un estudiante registrado
select c.id_carrera, c.nombre, count(e.id_estudiante) as cantidad_estudiantes
from carrera c
join estudiante e on c.id_carrera = e.id_carrera
group by c.id_carrera, c.nombre
having count(e.id_estudiante) > 1;
-- 7. mostrar el proyecto con el mayor nivel de innovacion del sistema
select * from proyecto where nivel_innovacion = (select max(nivel_innovacion) from proyecto);
-- 8. mostrar los estudiantes cuyos nombres empiecen con "M" o "A",  ordenados por semestre descendente
select * from estudiante where nombre like 'm%' or nombre like 'a%'
order by semestre desc;
-- 9. mostrar todas las materias junto con el nombre del docente y la carrera a la que pertenecen
select m.id_materia, m.nombre as materia, m.sigla, d.nombre, d.apellido, c.nombre as carrera
from materia m
inner join docente d on m.id_docente = d.id_docente
inner join carrera c on m.id_carrera = c.id_carrera;
-- 10. mostrar los proyectos que tengan archivos de tipo "video" o "pdf"
select p.id_proyecto, p.titulo, a.tipo_archivo
from proyecto p
join archivo_proyecto a on p.id_proyecto = a.id_proyecto
where a.tipo_archivo in ('video', 'pdf');
-- 11. mostrar los docentes que tengan proyectos ganadores en ferias
select d.id_docente, d.nombre, d.apellido
from docente d
join proyecto p on d.id_docente = p.id_docente
join proyecto_feria pf on p.id_proyecto = pf.id_proyecto
where pf.ganador = 1;
-- 12. mostrar las empresas que no realizaron ningun contacto a proyectos
select * from empresa where id_empresa not in (select id_empresa from contacto_empresa);
-- 13. mostrar los proyectos cuya innovacion este entre 85 y 100 y cuyo estado no sea en "desarrollo"
select * from proyecto where nivel_innovacion between 85 and 100 and estado != 'desarrollo';
-- 14. mostrar la cantidad de los proyectos por estado, pero solo aquellos estados que tengan mas de dos proyectos
select estado, count(*) as cantidad from proyecto group by estado having count(*) > 2;
-- 15. mostrar los estudiantes que no pertenecen a ningun equipo
select * from estudiante where id_estudiante not in (select id_estudiante from equipo_estudiante);
-- 16. mostrar el nombre de los proyectos y la cantidad de visitas recibidas, ordenados de mayor a menor cantidad
select p.titulo, count(v.id_visita) as cantidad_visitas
from proyecto p
left join visita_proyecto v on p.id_proyecto = v.id_proyecto
group by p.id_proyecto, p.titulo
order by cantidad_visitas desc;
-- 17. mostrar las inversiones cuyo presupuesto sea supeior al promedio de todas las inversiones
select * from inversion where presupuesto > (select avg(presupuesto) from inversion);
-- 18. crear una view llamada vista_proyectos_destacados que muestre proyectos ganadores con innovacion mayor a 95
create view vista_proyectos_destacados as
select p.id_proyecto, p.titulo, p.nivel_innovacion, p.estado, d.nombre, d.apellido
from proyecto p
join docente d on p.id_docente = d.id_docente
where p.estado = 'ganador' and p.nivel_innovacion > 95;
-- 19. mostrar los docentes cuyo puntaje en ranking sea mayor al promedio general de los docentes
select d.id_docente, d.nombre, d.apellido, rd.puntaje
from docente d
join ranking_docente rd on d.id_docente = rd.id_docente
where rd.puntaje > (select avg(puntaje) from ranking_docente);
-- 20. mostrar los proyectos que tienen comentarios registrados (usando exist)
select * from proyecto where exists (select 1 from comentario_proyecto where comentario_proyecto.id_proyecto = proyecto.id_proyecto);