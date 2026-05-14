-- 1. .Mostrar los proyectos ganadores con innovacion mayor a 90, junto al nombre del docente responsable, ordenados del mas innovador al menos innovador
SELECT 
    p.titulo,
    p.nivel_innovacion,
    CONCAT(d.nombre, ' ', d.apellido) AS docente_responsable
FROM proyecto p
INNER JOIN docente d ON p.id_docente = d.id_docente
WHERE p.estado = 'ganador' 
  AND p.nivel_innovacion > 90
ORDER BY p.nivel_innovacion DESC;
-- 2. Mostrar los estudiantes que pertenecen a equipos y que ademas esten en semestres entre 5 y 8
SELECT DISTINCT
    e.id_estudiante,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    e.semestre,
    eq.nombre_equipo
FROM estudiante e
INNER JOIN equipo_estudiante ee ON e.id_estudiante = ee.id_estudiante
INNER JOIN equipo eq ON ee.id_equipo = eq.id_equipo
WHERE e.semestre BETWEEN 5 AND 8
ORDER BY e.semestre, e.apellido;
-- 3. Mostrar las empresas que realizaron contactos a proyectos cuyo estado sea ganador
SELECT DISTINCT
    emp.nombre AS empresa,
    emp.rubro,
    emp.correo,
    p.titulo AS proyecto_ganador,
    c.mensaje,
    c.fecha_contacto
FROM empresa emp
INNER JOIN contacto_empresa c ON emp.id_empresa = c.id_empresa
INNER JOIN proyecto p ON c.id_proyecto = p.id_proyecto
WHERE p.estado = 'ganador'
ORDER BY c.fecha_contacto;
-- 4. Mostrar el promedio de innovacion por docente, pero unicamente de docentes cuyo promedio sea mayor a 90
SELECT 
    CONCAT(d.nombre, ' ', d.apellido) AS docente,
    d.especialidad,
    AVG(p.nivel_innovacion) AS promedio_innovacion,
    COUNT(p.id_proyecto) AS total_proyectos
FROM docente d
INNER JOIN proyecto p ON d.id_docente = p.id_docente
GROUP BY d.id_docente, d.nombre, d.apellido, d.especialidad
HAVING AVG(p.nivel_innovacion) > 90
ORDER BY promedio_innovacion DESC;
-- 5. Mostrar los proyectos que participaron en ferias y obtubieron puntuacion mayoy al promedio de todas las puntuaciones 
SELECT 
    p.titulo,
    p.nivel_innovacion,
    pf.puntuacion,
    f.nombre AS nombre_feria,
    pf.puesto,
    pf.ganador
FROM proyecto p
INNER JOIN proyecto_feria pf ON p.id_proyecto = pf.id_proyecto
INNER JOIN feria f ON pf.id_feria = f.id_feria
WHERE pf.puntuacion > (SELECT AVG(puntuacion) FROM proyecto_feria)
ORDER BY pf.puntuacion DESC;
-- 6. Mostrar las carreras que tienen mas de un estudiante registrado
SELECT 
    c.id_carrera,
    c.nombre AS carrera,
    c.descripcion,
    COUNT(e.id_estudiante) AS total_estudiantes
FROM carrera c
INNER JOIN estudiante e ON c.id_carrera = e.id_carrera
GROUP BY c.id_carrera, c.nombre, c.descripcion
HAVING COUNT(e.id_estudiante) > 1
ORDER BY total_estudiantes DESC;
-- 7. Mostrar el proyecto con el mayor nivel de innovacion del sistema
SELECT 
    p.id_proyecto,
    p.titulo,
    p.nivel_innovacion,
    p.descripcion,
    p.estado,
    CONCAT(d.nombre, ' ', d.apellido) AS docente_responsable
FROM proyecto p
INNER JOIN docente d ON p.id_docente = d.id_docente
WHERE p.nivel_innovacion = (SELECT MAX(nivel_innovacion) FROM proyecto);
-- 8. Mostrar los estudiantes cuyos nombres empiecen con M o A, ordenados por semestre descendente
SELECT 
    p.id_proyecto,
    p.titulo,
    p.nivel_innovacion,
    p.descripcion,
    p.estado,
    CONCAT(d.nombre, ' ', d.apellido) AS docente_responsable
FROM proyecto p
INNER JOIN docente d ON p.id_docente = d.id_docente
WHERE p.nivel_innovacion = (SELECT MAX(nivel_innovacion) FROM proyecto);
-- 9. Mostrar todas las materias junto con el nombre del docente y la carrera a la que pertenecen
SELECT 
    m.id_materia,
    m.nombre AS materia,
    m.sigla,
    m.semestre,
    CONCAT(d.nombre, ' ', d.apellido) AS docente,
    d.especialidad AS docente_especialidad,
    c.nombre AS carrera,
    c.descripcion AS carrera_descripcion
FROM materia m
LEFT JOIN docente d ON m.id_docente = d.id_docente
LEFT JOIN carrera c ON m.id_carrera = c.id_carrera
ORDER BY c.nombre, m.semestre, m.nombre;
-- 10. Mostrar los proyectos que tengan archivos de tipo video o pdfALTER
SELECT
  p.id_proyecto,
  p.descripcion,
  p.tipo_archivo
FROM archivo_proyecto p
WHERE p.tipo_archivo = 'video';