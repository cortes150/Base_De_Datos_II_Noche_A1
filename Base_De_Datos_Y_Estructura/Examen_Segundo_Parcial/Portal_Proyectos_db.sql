CREATE DATABASE portal_proyectos_db;
USE portal_proyectos_db;

-- =========================================
-- TABLA: carrera
-- =========================================
CREATE TABLE carrera (
    id_carrera INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- =========================================
-- TABLA: docente
-- =========================================
CREATE TABLE docente (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE,
    telefono VARCHAR(20),
    especialidad VARCHAR(100),
    trayectoria TEXT
);

-- =========================================
-- TABLA: estudiante
-- =========================================
CREATE TABLE estudiante (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE,
    telefono VARCHAR(20),
    semestre INT,
    fecha_registro DATE,
    id_carrera INT,
    
    FOREIGN KEY (id_carrera)
    REFERENCES carrera(id_carrera)
);

-- =========================================
-- TABLA: materia
-- =========================================
CREATE TABLE materia (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    sigla VARCHAR(20),
    semestre INT,
    id_carrera INT,
    id_docente INT,

    FOREIGN KEY (id_carrera)
    REFERENCES carrera(id_carrera),

    FOREIGN KEY (id_docente)
    REFERENCES docente(id_docente)
);

-- =========================================
-- TABLA: equipo
-- =========================================
CREATE TABLE equipo (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_equipo VARCHAR(100) NOT NULL,
    fecha_creacion DATE
);

-- =========================================
-- TABLA INTERMEDIA: equipo_estudiante
-- =========================================
CREATE TABLE equipo_estudiante (
    id_equipo INT,
    id_estudiante INT,
    rol VARCHAR(50),

    PRIMARY KEY (id_equipo, id_estudiante),

    FOREIGN KEY (id_equipo)
    REFERENCES equipo(id_equipo),

    FOREIGN KEY (id_estudiante)
    REFERENCES estudiante(id_estudiante)
);

-- =========================================
-- TABLA: proyecto
-- =========================================
CREATE TABLE proyecto (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    fecha_publicacion DATE,
    
    estado ENUM(
        'desarrollo',
        'finalizado',
        'publicado',
        'ganador'
    ),

    nivel_innovacion INT,
    repositorio_github VARCHAR(255),
    video_demo VARCHAR(255),

    id_materia INT,
    id_docente INT,

    FOREIGN KEY (id_materia)
    REFERENCES materia(id_materia),

    FOREIGN KEY (id_docente)
    REFERENCES docente(id_docente)
);

-- =========================================
-- TABLA INTERMEDIA: proyecto_equipo
-- =========================================
CREATE TABLE proyecto_equipo (
    id_proyecto INT,
    id_equipo INT,

    PRIMARY KEY (id_proyecto, id_equipo),

    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto),

    FOREIGN KEY (id_equipo)
    REFERENCES equipo(id_equipo)
);

-- =========================================
-- TABLA: feria
-- =========================================
CREATE TABLE feria (
    id_feria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150),
    fecha_inicio DATE,
    fecha_fin DATE,
    modulo VARCHAR(50),
    gestion YEAR
);

-- =========================================
-- TABLA: proyecto_feria
-- =========================================
CREATE TABLE proyecto_feria (
    id_proyecto_feria INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT,
    id_feria INT,
    
    puesto INT,
    ganador BOOLEAN,
    puntuacion DECIMAL(5,2),

    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto),

    FOREIGN KEY (id_feria)
    REFERENCES feria(id_feria)
);

-- =========================================
-- TABLA: empresa
-- =========================================
CREATE TABLE empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150),
    rubro VARCHAR(100),
    correo VARCHAR(150),
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    sitio_web VARCHAR(200)
);

-- =========================================
-- TABLA: contacto_empresa
-- =========================================
CREATE TABLE contacto_empresa (
    id_contacto INT AUTO_INCREMENT PRIMARY KEY,
    
    id_empresa INT,
    id_proyecto INT,

    mensaje TEXT,
    fecha_contacto DATETIME,

    FOREIGN KEY (id_empresa)
    REFERENCES empresa(id_empresa),

    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto)
);

-- =========================================
-- TABLA: archivo_proyecto
-- =========================================
CREATE TABLE archivo_proyecto (
    id_archivo INT AUTO_INCREMENT PRIMARY KEY,

    id_proyecto INT,

    tipo_archivo ENUM(
        'imagen',
        'video',
        'pdf',
        'documentacion',
        'codigo'
    ),

    url_archivo TEXT,
    descripcion TEXT,
    fecha_subida DATETIME,

    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto)
);

-- =========================================
-- TABLA: inversion
-- =========================================
CREATE TABLE inversion (
    id_inversion INT AUTO_INCREMENT PRIMARY KEY,

    titulo VARCHAR(150),
    descripcion TEXT,
    presupuesto DECIMAL(12,2),
    fecha_publicacion DATE,

    empresa_publicadora VARCHAR(150)
);

-- =========================================
-- TABLA: postulacion_inversion
-- =========================================
CREATE TABLE postulacion_inversion (
    id_postulacion INT AUTO_INCREMENT PRIMARY KEY,

    id_inversion INT,
    id_proyecto INT,

    estado ENUM(
        'pendiente',
        'aceptado',
        'rechazado'
    ),

    fecha_postulacion DATE,

    FOREIGN KEY (id_inversion)
    REFERENCES inversion(id_inversion),

    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto)
);

-- =========================================
-- TABLA: ranking_docente
-- =========================================
CREATE TABLE ranking_docente (
    id_ranking_docente INT AUTO_INCREMENT PRIMARY KEY,

    id_docente INT,

    proyectos_ganadores INT,
    puntaje INT,

    FOREIGN KEY (id_docente)
    REFERENCES docente(id_docente)
);

-- =========================================
-- TABLA: ranking_estudiante
-- =========================================
CREATE TABLE ranking_estudiante (
    id_ranking_estudiante INT AUTO_INCREMENT PRIMARY KEY,

    id_estudiante INT,

    proyectos_destacados INT,
    puntaje INT,

    FOREIGN KEY (id_estudiante)
    REFERENCES estudiante(id_estudiante)
);

-- =========================================
-- TABLA: visita_proyecto
-- =========================================
CREATE TABLE visita_proyecto (
    id_visita INT AUTO_INCREMENT PRIMARY KEY,

    id_proyecto INT,

    fecha_visita DATETIME,
    ip_visitante VARCHAR(50),
    pais VARCHAR(100),

    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto)
);

-- =========================================
-- TABLA: comentario_proyecto
-- =========================================
CREATE TABLE comentario_proyecto (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,

    id_proyecto INT,

    nombre_visitante VARCHAR(100),
    comentario TEXT,
    fecha_comentario DATETIME,

    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto)
);