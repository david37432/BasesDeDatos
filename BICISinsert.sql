USE BICIS2;

ALTER TABLE pais
ALTER COLUMN prefijo_telefonico VARCHAR(50)

INSERT INTO pais(id_pais, pais, prefijo_telefonico)
VALUES (101,'Colombia','+57');

INSERT INTO ciudad (id_ciudad, id_pais, ciudad)
VALUES
    (20000, 101, 'Bogotá');


INSERT INTO universidad (id_universidad, universidad, id_ciudad)
VALUES
    (5000, 'Sabana', 20000);


INSERT INTO carrera (id_carrera,nombre_carrera, facultad)
VALUES
    (2000, 'Ingeniería Civil', 'Ingeniería y Ciencias'),
	(2001, 'Ingeniería Quimica', 'Ingeniería y Ciencias'),
    (2002, 'Economía', 'Ciencias Sociales'),
    (2003, 'Derecho', 'Ciencias Jurídicas'),
    (2004, 'Psicología', 'Ciencias del Comportamiento'),
    (2005, 'Arquitectura', 'Artes y Diseño'),
    (2006, 'Contaduría Pública', 'Ciencias Económicas'),
    (2007, 'Ingeniería de Sistemas', 'Ingeniería y Ciencias'),
    (2008, 'Comunicación Social', 'Ciencias Sociales'),
    (2009, 'Enfermería', 'Ciencias de la Salud');



BULK INSERT registro
FROM 'C:\\Users\\tavoe\\OneDrive\\Documentos\\Cuarto semestre\\Bases de datos\\DatosRegistroFinal.txt'  -- Especifica la ruta del archivo de texto
WITH (
	FIELDTERMINATOR = ',',  -- Especifica el carácter que separa los campos en el archivo (en este caso, una coma)
	ROWTERMINATOR = '\' ,  -- Especifica el carácter de terminación de línea en el archivo (en este caso, un salto de línea)
	FIRSTROW = 1           -- Especifica la primera fila del archivo donde comienza la inserción (en este caso, la primera fila)
	);



INSERT INTO proveedor (id_proveedor, nombre_proveedor, telefono, direccion, id_ciudad)
VALUES
    (16000, 'Bicicletas Rápidas', '555-123-4567', 'Calle Principal 123', 20000),
    (16001, 'CicloMundo', '555-987-6543', 'Avenida del Ciclista 456', 20000),
    (16002, 'Pedal Feliz', '555-555-1212', 'Carrera de las Bicis 789', 20000),
    (16003, 'Ruedas Veloces', '555-246-8135', 'Calle de las Bicicletas 234', 20000),
    (16004, 'BiciShop', '555-777-8888', 'Avenida de los Ciclos 567', 20000),
    (16005, 'Pedaleando', '555-321-6549', 'Calle de las Ruedas 890', 20000),
    (16006, 'BiciFácil', '555-444-5678', 'Avenida de los Pedales 123', 20000),
    (16007, 'CicloAventura', '555-888-9999', 'Carrera de las Bicicletas 456', 20000),
    (16008, 'Rodando Bicis', '555-666-3333', 'Calle de los Ciclistas 789', 20000),
    (16009, 'BiciExpress', '555-222-7777', 'Avenida de las Ruedas 234', 20000),
    (16010, 'BiciMundo', '555-444-5555', 'Carrera de los Pedales 567', 20000);



INSERT INTO marca (id_marca, marca, id_proveedor)
VALUES
    (15000, 'Trek', 16000),
    (15001, 'Giant', 16001),
    (15002, 'Specialized', 16002),
    (15003, 'Cannondale', 16003),
    (15004, 'Scott', 16004);

INSERT INTO tipo_cambio (id_tipo_cambio, tipo_cambio, id_proveedor)
VALUES
    (17000, 'Cambio de marchas', 16000),
    (17001, 'Cambio de piñón', 16001),
    (17002, 'Cambio de cadena', 16002),
    (17003, 'Cambio de rueda libre', 16003),
    (17004, 'Cambio de plato', 16004);



INSERT INTO tipo_freno (id_tipo_freno, tipo_freno, id_proveedor)
VALUES
    (18000, 'Freno de llanta', 16000),
    (18001, 'Freno de disco', 16001),
    (18002, 'Freno de tambor', 16002),
    (18003, 'Freno de contrapedal', 16003),
    (18004, 'Freno de pinza', 16004);


INSERT INTO material_fabricacion (id_material_fabricacion, material_fabriacion, resistencia)
VALUES
    (19000, 'Acero', 'Alta'),
    (19001, 'Aluminio', 'Mediana'),
    (19002, 'Titanio', 'Baja'),
    (19003, 'Fibra de carbono', 'Alta'),
    (19004, 'Cromoly', 'Mediana'),
    (19005, 'Magnesio', 'Baja'),
    (19006, 'Aleación de aluminio', 'Alta'),
    (19007, 'Acero inoxidable', 'Mediana'),
    (19008, 'Plástico reforzado con fibra de vidrio', 'Baja'),
    (19009, 'Titanio Grado 5', 'Alta'),
    (19010, 'Aluminio 7075', 'Mediana');


INSERT INTO tipo_bicicleta (id_tipo_bicicleta, tipo_bicicleta, id_marca, id_material_fabricacion, id_tipo_freno, id_tipo_cambio)
VALUES
(21000, 'Montaña', 15000, 19000, 18000, 17000),
(21001, 'Carretera', 15001, 19001, 18001, 17001),
(21002, 'Híbrida', 15002, 19002, 18002, 17002),
(21003, 'Ciudad', 15003, 19003, 18003, 17003),
(21004, 'Plegable', 15004, 19004, 18004, 17004),
(21005, 'Touring', 15000, 19005, 18000, 17000),
(21006, 'Pista', 15001, 19006, 18001, 17001),
(21007, 'Gravel', 15002, 19007, 18002, 17002),
(21008, 'Montaña', 15003, 19008, 18003, 17003),
(21009, 'Carretera', 15004, 19009, 18004, 17004),
(21010, 'Híbrida', 15000, 19010, 18000, 17000),
(21011, 'Ciudad', 15001, 19000, 18001, 17001),
(21012, 'Plegable', 15002, 19001, 18002, 17002),
(21013, 'Touring', 15003, 19002, 18003, 17003),
(21014, 'Pista', 15004, 19003, 18004, 17004),
(21015, 'Gravel', 15000, 19004, 18000, 17000),
(21016, 'Montaña', 15001, 19005, 18001, 17001),
(21017, 'Carretera', 15002, 19006, 18002, 17002),
(21018, 'Híbrida', 15003, 19007, 18003, 17003),
(21019, 'Ciudad', 15004, 19008, 18004, 17004),
(21020, 'Plegable', 15000, 19009, 18000, 17000),
(21021, 'Touring', 15001, 19010, 18001, 17001),
(21022, 'Pista', 15002, 19000, 18002, 17002),
(21023, 'Gravel', 15003, 19001, 18003, 17003),
(21024, 'Montaña', 15004, 19002, 18004, 17004),
(21025, 'Carretera', 15000, 19003, 18000, 17000),
(21026, 'Híbrida', 15001, 19004, 18001, 17001),
(21027, 'Ciudad', 15002, 19005, 18002, 17002),
(21028, 'Plegable', 15003, 19006, 18003, 17003),
(21029, 'Touring', 15004, 19007, 18004, 17004),
(21030, 'Pista', 15000, 19008, 18000, 17000),
(21031, 'Gravel', 15001, 19009, 18001, 17001),
(21032, 'Montaña', 15002, 19010, 18002, 17002),
(21033, 'Carretera', 15003, 19000, 18003, 17003),
(21034, 'Híbrida', 15004, 19001, 18004, 17004),
(21035, 'Ciudad', 15000, 19002, 18000, 17000),
(21036, 'Plegable', 15001, 19003, 18001, 17001),
(21037, 'Touring', 15002, 19004, 18002, 17002),
(21038, 'Pista', 15003, 19005, 18003, 17003),
(21039, 'Gravel', 15004, 19006, 18004, 17004),
(21040, 'Montaña', 15000, 19007, 18000, 17000),
(21041, 'Carretera', 15001, 19008, 18001, 17001),
(21042, 'Híbrida', 15002, 19009, 18002, 17002),
(21043, 'Ciudad', 15003, 19010, 18003, 17003),
(21044, 'Plegable', 15004, 19000, 18004, 17004),
(21045, 'Touring', 15000, 19001, 18000, 17000),
(21046, 'Pista', 15001, 19002, 18001, 17001),
(21047, 'Gravel', 15002, 19003, 18002, 17002),
(21048, 'Montaña', 15003, 19004, 18003, 17003),
(21049, 'Carretera', 15004, 19005, 18004, 17004),
(21050, 'Híbrida', 15000, 19006, 18000, 17000);



BULK INSERT bicicleta
FROM 'C:\Users\tavoe\OneDrive\Documentos\Cuarto semestre\Bases de datos\DatosBicis.txt'  -- Especifica la ruta del archivo de texto
WITH (
	FIELDTERMINATOR = ',',  -- Especifica el carácter que separa los campos en el archivo (en este caso, una coma)
	ROWTERMINATOR = '/' ,  -- Especifica el carácter de terminación de línea en el archivo (en este caso, un salto de línea)
	FIRSTROW = 1           -- Especifica la primera fila del archivo donde comienza la inserción (en este caso, la primera fila)
	);



INSERT INTO  quiosco (id_quiosco, quiosco, id_universidad, cantidad_bicicleta)
VALUES
    (13000, 'Embarcadero', 5000, 7),
    (13001, 'Mezon', 5000, 7),
    (13002, 'Tablitas', 5000, 4),
    (13003, 'Agora', 5000, 9),
	(13004, 'Edificio A', 5000, 12),
    (13005, 'Cafe Bolsa', 5000, 7),
	(13006, 'Punto Verde', 5000, 7),
	(13007, 'Edificio G', 5000, 2),
	(13008, 'Ad Portas', 5000, 7),
	(13009, 'Biblioteca', 5000, 5),
	(13010, 'Edificio K', 5000, 10),
	(13011, 'Fab Lab', 5000, 11),
	(13012, 'Arena Sabana', 5000, 15),
	(13013, 'Atelier', 5000,10 ),
	(13014, 'Edificio B', 5000, 14),
	(13015, 'CAF', 5000, 6),
	(13016, 'Punto Sandwich', 5000, 10),
	(13017, 'Edifico E', 5000, 10),
	(13018, 'Puente gris', 5000, 8),
	(13019, 'Living Lab', 5000, 10),
	(13020, 'Villa de Leyva', 5000, 9);





INSERT INTO hoja_prestamo (id_prestamo, placa, id_estudiante, fecha_prestamo, condiciones_iniciales, condiciones_devolucion, id_quiosco_salida, id_quiosco_entrada, fecha_devolucion)
VALUES
(30000251, 20000002, 10000004, '10/7/2021', 'pesimo', NULL, 13003, NULL, NULL);
UPDATE hoja_prestamo
SET 
	condiciones_devolucion='excelente',
    id_quiosco_entrada = 13004,
    fecha_devolucion = '11/9/2021'
WHERE id_prestamo = 30000248;

INSERT INTO quiosco (id_quiosco, quiosco, id_universidad, cantidad_bicicleta)
VALUES (13021, 'clinica Sabana', 5000, 0);
SELECT * FROM estudiante WHERE id_registro=11000001;
INSERT INTO registro (id_registro, cedula, nombre, apellido, id_carrera, semestre, edad, numero_telefono, direccion, confirmacion_pago)
VALUES (11000001, '1234567890', 'Juan', 'Pérez', 2000, 5, 20, '123456789', 'Calle Principal 123', 1);