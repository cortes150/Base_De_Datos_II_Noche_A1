CREATE DATABASE cocacola;
USE cocacola;
create table categoria (
    id_categoria int AUTO_INCREMENT primary key,
    nombre varchar(40) not null, 
    descripcion varchar (90) 
);
create table producto (
    id_producto int AUTO_INCREMENT primary key,
    id_categoria int,
    presentacion varchar (90) not null,
    nombre varchar (40) not null,
    direccion varchar (40) not null,
    estado varchar (10) default 'activo',
    precio varchar (40) not null,
    FOREIGN key (id_categoria) REFERENCES categoria (id_categoria),
    )