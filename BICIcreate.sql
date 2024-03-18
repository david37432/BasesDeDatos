CREATE DATABASE BICIS2; 
USE BICIS2; 
 
CREATE TABLE pais (
 id_pais INT NOT NULL PRIMARY KEY, 
 pais VARCHAR(50) NOT NULL, 
 prefijo_telefonico VARCHAR NOT NULL
 );

 CREATE TABLE ciudad(
 id_ciudad INT NOT NULL PRIMARY KEY, 
 id_pais INT NOT NULL FOREIGN KEY REFERENCES pais(id_pais),
 ciudad VARCHAR(50) NOT NULL 

 );

 CREATE TABLE universidad(
 id_universidad INT NOT NULL PRIMARY KEY, 
 universidad VARCHAR (50) NOT NULL, 
 id_ciudad INT NOT NULL FOREIGN KEY REFERENCES ciudad(id_ciudad)
 );

 CREATE TABLE carrera(
 id_carrera INT PRIMARY KEY NOT NULL, 
 nombre_carrera VARCHAR (50) NOT NULL, 
 facultad VARCHAR (50)NOT NULL
 );

 CREATE TABLE registro (
    id_registro INT PRIMARY KEY NOT NULL,
    cedula VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    id_carrera INT NOT NULL FOREIGN KEY REFERENCES carrera(id_carrera),
    semestre INT,
    edad INT NOT NULL,
    numero_telefono VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) ,
    confirmacion_pago INT NOT NULL
);

 CREATE TABLE estudiante(
  id_registro INT NOT NULL FOREIGN KEY REFERENCES registro(id_registro), 
  id_universidad INT NOT NULL FOREIGN KEY REFERENCES universidad(id_universidad),
  telefono_emergencia VARCHAR(50)
 );

 CREATE TABLE proveedor(
 id_proveedor INT NOT NULL PRIMARY KEY,
 nombre_proveedor VARCHAR (50) NOT NULL, 
 telefono INT NOT NULL, 
 direccion VARCHAR (50) NOT NULL, 
 id_ciudad INT NOT NULL FOREIGN KEY REFERENCES ciudad(id_ciudad)
 );

 CREATE TABLE marca(
 id_marca INT NOT NULL PRIMARY KEY, 
 marca VARCHAR (50) NOT NULL, 
 id_proveedor INT NOT NULL FOREIGN KEY REFERENCES proveedor (id_proveedor)
 );

 CREATE TABLE tipo_cambio(
 id_tipo_cambio INT NOT NULL PRIMARY KEY, 
 tipo_cambio VARCHAR (50) NOT NULL, 
 id_proveedor INT NOT NULL FOREIGN KEY REFERENCES proveedor(id_proveedor)
 );

 CREATE TABLE tipo_freno(
 id_tipo_freno INT NOT NULL PRIMARY KEY,
 tipo_freno VARCHAR (50) NOT NULL, 
 id_proveedor INT NOT NULL FOREIGN KEY REFERENCES proveedor(id_proveedor)
 );

 CREATE TABLE material_fabricacion(
 id_material_fabricacion INT NOT NULL PRIMARY KEY,
 material_fabriacion VARCHAR (50) NOT NULL, 
 resistencia VARCHAR (50)NOT NULL
 );

 CREATE TABLE tipo_bicicleta (
 id_tipo_bicicleta INT NOT NULL PRIMARY KEY, 
 tipo_bicicleta VARCHAR (50) NOT NULL, 
 id_marca INT NOT NULL FOREIGN KEY REFERENCES marca(id_marca),
 id_material_fabricacion INT NOT NULL FOREIGN KEY REFERENCES material_fabricacion(id_material_fabricacion),
 id_tipo_freno INT NOT NULL FOREIGN KEY REFERENCES tipo_freno(id_tipo_freno),
 id_tipo_cambio INT NOT NULL FOREIGN KEY REFERENCES tipo_cambio(id_tipo_cambio)
 );

 CREATE TABLE bicicleta (
 placa INT NOT NULL PRIMARY KEY,
 condiciones_actuales VARCHAR(50) NOT NULL, 
 ultimo_mantenimiento DATE, 
 id_tipo_bicicleta INT NOT NULL FOREIGN KEY REFERENCES tipo_bicicleta(id_tipo_bicicleta),
 año_fabricacion INT NOT NULL
 );

 CREATE TABLE quiosco (
 id_quiosco INT  PRIMARY KEY,
 quiosco VARCHAR (50),
 id_universidad INT NOT NULL FOREIGN KEY REFERENCES universidad(id_universidad),
 cantidad_bicicleta INT
 );

 CREATE TABLE quiosco_bicicleta (
 id_quiosco INT NOT NULL FOREIGN KEY REFERENCES quiosco(id_quiosco), 
 placa INT NOT NULL FOREIGN KEY REFERENCES bicicleta(placa),
 estado INT NOT NULL
 );


 CREATE TABLE hoja_prestamo(
 id_prestamo INT NOT NULL PRIMARY KEY, 
 placa INT NOT NULL FOREIGN KEY REFERENCES bicicleta(placa),
 id_estudiante INT NOT NULL FOREIGN KEY REFERENCES registro(id_registro),
 fecha_prestamo DATE, 
 condiciones_iniciales VARCHAR (50) NOT NULL, 
 condiciones_devolucion VARCHAR(50),
 id_quiosco_salida INT FOREIGN KEY REFERENCES quiosco(id_quiosco),
 id_quiosco_entrada INT FOREIGN KEY REFERENCES quiosco(id_quiosco),
 fecha_devolucion DATE
 );





