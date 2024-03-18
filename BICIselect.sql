
USE BICIS2;
	SELECT*FROM hoja_prestamo;
SELECT*FROM quiosco_bicicleta;

SELECT COUNT(*) AS total_registros
FROM registro;

 SELECT id_estudi
 FROM hoja_prestamo
 WHERE id_estudiante=16433611;

SELECT * FROM estudiante;


DELETE FROM hoja_prestamo;
DELETE FROM registro;
DELETE FROM quiosco_bicicleta;
DELETE FROM estudiante;
DELETE FROM bicicleta;


 ALTER TABLE bicicleta
ALTER COLUMN  placa INT NULL;

DELETE FROM  bicicleta


 
