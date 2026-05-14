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
USE portal_proyectos_db;

-- =========================================
-- INSERTS TABLA: carrera
-- =========================================
INSERT INTO carrera(nombre, descripcion) VALUES
('Ingeniería de Sistemas','Desarrollo de software y tecnologías'),
('Ingeniería Autotrónica','Electrónica aplicada a vehículos'),
('Ingeniería Automotriz','Diseño y mantenimiento automotriz'),
('Ingeniería Industrial','Optimización de procesos'),
('Ingeniería Civil','Infraestructura y construcción'),
('Ingeniería Electrónica','Sistemas electrónicos'),
('Ingeniería Mecatrónica','Automatización y robótica'),
('Ingeniería Comercial','Gestión empresarial'),
('Diseño Gráfico','Diseño digital y multimedia'),
('Arquitectura','Diseño arquitectónico');

-- =========================================
-- INSERTS TABLA: docente
-- =========================================
INSERT INTO docente(nombre, apellido, correo, telefono, especialidad, trayectoria) VALUES
('Carlos','Mendoza','cmendoza@mail.com','77711111','Inteligencia Artificial','10 años en IA'),
('Ana','Torres','atorres@mail.com','77711112','Base de Datos','Especialista SQL'),
('Luis','Rojas','lrojas@mail.com','77711113','Redes','Cisco Certified'),
('María','Lopez','mlopez@mail.com','77711114','Desarrollo Web','Fullstack Developer'),
('Pedro','Vargas','pvargas@mail.com','77711115','Robótica','Investigador'),
('Lucía','Perez','lperez@mail.com','77711116','Automotriz','Experta híbridos'),
('Diego','Flores','dflores@mail.com','77711117','Electrónica','IoT Specialist'),
('Jorge','Santos','jsantos@mail.com','77711118','Cloud Computing','AWS Architect'),
('Marta','Suarez','msuarez@mail.com','77711119','UX/UI','Diseñadora Senior'),
('Ricardo','Nina','rnina@mail.com','77711120','Ciberseguridad','Pentester');

-- =========================================
-- INSERTS TABLA: estudiante
-- =========================================
INSERT INTO estudiante(nombre, apellido, correo, telefono, semestre, fecha_registro, id_carrera) VALUES
('Juan','Perez','juan@mail.com','70000001',5,'2025-01-10',1),
('Maria','Lopez','maria@mail.com','70000002',6,'2025-01-10',1),
('Carlos','Diaz','carlos@mail.com','70000003',7,'2025-01-10',2),
('Ana','Torres','ana@mail.com','70000004',8,'2025-01-10',3),
('Luis','Rojas','luis@mail.com','70000005',4,'2025-01-10',1),
('Sofia','Mendoza','sofia@mail.com','70000006',3,'2025-01-10',2),
('Miguel','Vargas','miguel@mail.com','70000007',5,'2025-01-10',3),
('Laura','Flores','laura@mail.com','70000008',6,'2025-01-10',4),
('Diego','Santos','diego@mail.com','70000009',7,'2025-01-10',5),
('Valeria','Nina','valeria@mail.com','70000010',8,'2025-01-10',1);

-- =========================================
-- INSERTS TABLA: materia
-- =========================================
INSERT INTO materia(nombre, sigla, semestre, id_carrera, id_docente) VALUES
('Base de Datos','BDD101',5,1,2),
('Programación Web','PRW201',6,1,4),
('Inteligencia Artificial','IA301',7,1,1),
('Electrónica Automotriz','ELA101',5,2,6),
('Robótica','ROB202',6,7,5),
('Redes','RED101',4,1,3),
('Cloud Computing','CLOUD301',7,1,8),
('UX/UI','UX101',3,9,9),
('Ciberseguridad','SEG401',8,1,10),
('IoT','IOT201',6,6,7);

-- =========================================
-- INSERTS TABLA: equipo
-- =========================================
INSERT INTO equipo(nombre_equipo, fecha_creacion) VALUES
('Tech Titans','2025-01-15'),
('Code Masters','2025-01-15'),
('AutoBots','2025-01-15'),
('Future Minds','2025-01-15'),
('Cyber Team','2025-01-15'),
('Smart Innovators','2025-01-15'),
('Vision Tech','2025-01-15'),
('NextGen','2025-01-15'),
('Digital Warriors','2025-01-15'),
('AI Creators','2025-01-15');

-- =========================================
-- INSERTS TABLA: equipo_estudiante
-- =========================================
INSERT INTO equipo_estudiante(id_equipo,id_estudiante,rol) VALUES
(1,1,'Lider'),
(1,2,'Backend'),
(2,3,'Frontend'),
(2,4,'Tester'),
(3,5,'Diseñador'),
(3,6,'Programador'),
(4,7,'Analista'),
(5,8,'DBA'),
(6,9,'Developer'),
(7,10,'Scrum Master');

-- =========================================
-- INSERTS TABLA: proyecto
-- =========================================
INSERT INTO proyecto(
titulo,descripcion,fecha_publicacion,estado,
nivel_innovacion,repositorio_github,video_demo,
id_materia,id_docente
) VALUES
('Sistema Smart Parking','Parqueo inteligente','2025-06-01','ganador',95,'github.com/p1','youtube.com/v1',1,2),
('IA Médica','Diagnóstico con IA','2025-06-02','publicado',98,'github.com/p2','youtube.com/v2',3,1),
('Auto Electric','Control vehicular','2025-06-03','finalizado',88,'github.com/p3','youtube.com/v3',4,6),
('Robot Delivery','Robot repartidor','2025-06-04','ganador',99,'github.com/p4','youtube.com/v4',5,5),
('Cloud Notes','Notas en la nube','2025-06-05','publicado',85,'github.com/p5','youtube.com/v5',7,8),
('Cyber Shield','Seguridad web','2025-06-06','desarrollo',90,'github.com/p6','youtube.com/v6',9,10),
('IoT Home','Casa inteligente','2025-06-07','publicado',91,'github.com/p7','youtube.com/v7',10,7),
('UniFood','Pedidos universitarios','2025-06-08','finalizado',80,'github.com/p8','youtube.com/v8',2,4),
('AutoScan','Escáner automotriz','2025-06-09','ganador',96,'github.com/p9','youtube.com/v9',4,6),
('EduVirtual','Educación virtual','2025-06-10','publicado',87,'github.com/p10','youtube.com/v10',2,4);

-- =========================================
-- INSERTS TABLA: proyecto_equipo
-- =========================================
INSERT INTO proyecto_equipo(id_proyecto,id_equipo) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

-- =========================================
-- INSERTS TABLA: feria
-- =========================================
INSERT INTO feria(nombre,fecha_inicio,fecha_fin,modulo,gestion) VALUES
('ExpoTech 2025','2025-06-01','2025-06-03','Modulo 1',2025),
('InnovateFest','2025-07-01','2025-07-03','Modulo 2',2025),
('Tech Future','2025-08-01','2025-08-03','Modulo 3',2025),
('AutoShow','2025-09-01','2025-09-03','Modulo 4',2025),
('CyberFest','2025-10-01','2025-10-03','Modulo 5',2025),
('AI Congress','2025-11-01','2025-11-03','Modulo 6',2025),
('Smart World','2025-12-01','2025-12-03','Modulo 7',2025),
('Digital Expo','2025-06-15','2025-06-17','Modulo 1',2025),
('Future Lab','2025-07-15','2025-07-17','Modulo 2',2025),
('Innovation Day','2025-08-15','2025-08-17','Modulo 3',2025);

-- =========================================
-- INSERTS TABLA: proyecto_feria
-- =========================================
INSERT INTO proyecto_feria(id_proyecto,id_feria,puesto,ganador,puntuacion) VALUES
(1,1,1,1,98),
(2,1,2,0,95),
(3,2,1,1,97),
(4,2,2,0,93),
(5,3,1,1,99),
(6,3,3,0,85),
(7,4,1,1,96),
(8,4,2,0,90),
(9,5,1,1,100),
(10,5,2,0,92);

-- =========================================
-- INSERTS TABLA: empresa
-- =========================================
INSERT INTO empresa(nombre,rubro,correo,telefono,direccion,sitio_web) VALUES
('Google','Tecnología','google@mail.com','800001','USA','google.com'),
('Tesla','Automotriz','tesla@mail.com','800002','USA','tesla.com'),
('Microsoft','Software','microsoft@mail.com','800003','USA','microsoft.com'),
('Toyota','Automotriz','toyota@mail.com','800004','Japón','toyota.com'),
('IBM','Cloud','ibm@mail.com','800005','USA','ibm.com'),
('Samsung','Electrónica','samsung@mail.com','800006','Corea','samsung.com'),
('Huawei','Telecom','huawei@mail.com','800007','China','huawei.com'),
('Amazon','Cloud','amazon@mail.com','800008','USA','amazon.com'),
('Meta','Redes Sociales','meta@mail.com','800009','USA','meta.com'),
('Nvidia','IA','nvidia@mail.com','800010','USA','nvidia.com');

-- =========================================
-- INSERTS TABLA: contacto_empresa
-- =========================================
INSERT INTO contacto_empresa(id_empresa,id_proyecto,mensaje,fecha_contacto) VALUES
(1,1,'Interesados en invertir','2025-06-01 10:00:00'),
(2,3,'Proyecto automotriz interesante','2025-06-02 11:00:00'),
(3,5,'Queremos alianza','2025-06-03 12:00:00'),
(4,9,'Interesados en tecnología','2025-06-04 13:00:00'),
(5,2,'Reunión de negocio','2025-06-05 14:00:00'),
(6,7,'Solicitud de demo','2025-06-06 15:00:00'),
(7,6,'Posible contratación','2025-06-07 16:00:00'),
(8,4,'Oferta de inversión','2025-06-08 17:00:00'),
(9,8,'Alianza estratégica','2025-06-09 18:00:00'),
(10,10,'Contacto empresarial','2025-06-10 19:00:00');

-- =========================================
-- INSERTS TABLA: archivo_proyecto
-- =========================================
INSERT INTO archivo_proyecto(id_proyecto,tipo_archivo,url_archivo,descripcion,fecha_subida) VALUES
(1,'pdf','url1','Documento final','2025-06-01 10:00:00'),
(2,'video','url2','Demo IA','2025-06-01 11:00:00'),
(3,'imagen','url3','Captura sistema','2025-06-01 12:00:00'),
(4,'codigo','url4','Repositorio','2025-06-01 13:00:00'),
(5,'documentacion','url5','Manual técnico','2025-06-01 14:00:00'),
(6,'pdf','url6','Informe seguridad','2025-06-01 15:00:00'),
(7,'video','url7','Video IoT','2025-06-01 16:00:00'),
(8,'imagen','url8','Diseño app','2025-06-01 17:00:00'),
(9,'codigo','url9','Código fuente','2025-06-01 18:00:00'),
(10,'pdf','url10','Presentación','2025-06-01 19:00:00');

-- =========================================
-- INSERTS TABLA: inversion
-- =========================================
INSERT INTO inversion(titulo,descripcion,presupuesto,fecha_publicacion,empresa_publicadora) VALUES
('IA Médica','Buscamos soluciones IA',50000,'2025-06-01','Google'),
('Smart Cars','Tecnología automotriz',70000,'2025-06-02','Tesla'),
('Cloud Apps','Sistemas cloud',40000,'2025-06-03','Amazon'),
('Cybersecurity','Seguridad digital',30000,'2025-06-04','IBM'),
('IoT Solutions','IoT industrial',60000,'2025-06-05','Huawei'),
('EduTech','Tecnología educativa',25000,'2025-06-06','Microsoft'),
('Smart Cities','Ciudades inteligentes',80000,'2025-06-07','Samsung'),
('AI Robotics','Robótica avanzada',90000,'2025-06-08','Nvidia'),
('Web Innovation','Apps web modernas',35000,'2025-06-09','Meta'),
('Automation','Automatización industrial',75000,'2025-06-10','Toyota');

-- =========================================
-- INSERTS TABLA: postulacion_inversion
-- =========================================
INSERT INTO postulacion_inversion(id_inversion,id_proyecto,estado,fecha_postulacion) VALUES
(1,2,'aceptado','2025-06-11'),
(2,3,'pendiente','2025-06-11'),
(3,5,'aceptado','2025-06-11'),
(4,6,'rechazado','2025-06-11'),
(5,7,'aceptado','2025-06-11'),
(6,10,'pendiente','2025-06-11'),
(7,1,'aceptado','2025-06-11'),
(8,4,'aceptado','2025-06-11'),
(9,8,'rechazado','2025-06-11'),
(10,9,'aceptado','2025-06-11');

-- =========================================
-- INSERTS TABLA: ranking_docente
-- =========================================
INSERT INTO ranking_docente(id_docente,proyectos_ganadores,puntaje) VALUES
(1,5,98),
(2,4,95),
(3,2,85),
(4,3,90),
(5,6,99),
(6,5,97),
(7,2,88),
(8,3,89),
(9,1,80),
(10,4,94);

-- =========================================
-- INSERTS TABLA: ranking_estudiante
-- =========================================
INSERT INTO ranking_estudiante(id_estudiante,proyectos_destacados,puntaje) VALUES
(1,3,90),
(2,4,95),
(3,2,80),
(4,5,98),
(5,1,75),
(6,2,82),
(7,6,99),
(8,3,88),
(9,2,84),
(10,4,93);

-- =========================================
-- INSERTS TABLA: visita_proyecto
-- =========================================
INSERT INTO visita_proyecto(id_proyecto,fecha_visita,ip_visitante,pais) VALUES
(1,'2025-06-01 10:00:00','192.168.1.1','Bolivia'),
(2,'2025-06-01 11:00:00','192.168.1.2','Perú'),
(3,'2025-06-01 12:00:00','192.168.1.3','Chile'),
(4,'2025-06-01 13:00:00','192.168.1.4','Argentina'),
(5,'2025-06-01 14:00:00','192.168.1.5','Brasil'),
(6,'2025-06-01 15:00:00','192.168.1.6','México'),
(7,'2025-06-01 16:00:00','192.168.1.7','Colombia'),
(8,'2025-06-01 17:00:00','192.168.1.8','España'),
(9,'2025-06-01 18:00:00','192.168.1.9','USA'),
(10,'2025-06-01 19:00:00','192.168.1.10','Canadá');

-- =========================================
-- INSERTS TABLA: comentario_proyecto
-- =========================================
INSERT INTO comentario_proyecto(id_proyecto,nombre_visitante,comentario,fecha_comentario) VALUES
(1,'Pedro','Excelente proyecto','2025-06-01 10:00:00'),
(2,'Maria','Muy innovador','2025-06-01 11:00:00'),
(3,'Luis','Gran trabajo','2025-06-01 12:00:00'),
(4,'Ana','Felicidades','2025-06-01 13:00:00'),
(5,'Carlos','Muy útil','2025-06-01 14:00:00'),
(6,'Sofia','Interesante idea','2025-06-01 15:00:00'),
(7,'Miguel','Buen diseño','2025-06-01 16:00:00'),
(8,'Laura','Excelente app','2025-06-01 17:00:00'),
(9,'Diego','Muy creativo','2025-06-01 18:00:00'),
(10,'Valeria','Proyecto destacado','2025-06-01 19:00:00');