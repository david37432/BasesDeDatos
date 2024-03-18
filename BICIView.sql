USE BICIS2;

CREATE VIEW EstudiantesSinPrestamo AS
SELECT e.id_registro
FROM estudiante e
LEFT JOIN hoja_prestamo hp ON e.id_registro = hp.id_estudiante
WHERE hp.id_estudiante IS NULL;

DROP VIEW EstudiantesSinPrestamo;
SELECT * FROM EstudiantesSinPrestamo;

CREATE VIEW EstudiantesConPrestamo AS
SELECT id_estudiante
FROM hoja_prestamo;

SELECT * FROM EstudiantesConPrestamo;

DROP VIEW RegistrosConPrestamo;



CREATE VIEW VistaInformacionBicicletas AS
SELECT 
 
    hp.id_estudiante,
    hp.placa,
    hp.id_quiosco_entrada,
    hp.id_quiosco_salida,
	hp.fecha_prestamo,
	hp.fecha_devolucion
FROM 
    hoja_prestamo hp;


select * from VistaInformacionBicicletas;
drop view VistaInformacionBicicletas;

USE BICIS2;

CREATE PROCEDURE PresentarVistas
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    BEGIN TRANSACTION;

    -- Prestamos por quioscos
    SELECT 'Prestamos por quioscos' AS Titulo;
    SELECT
        id_quiosco_entrada AS id_quiosco,
        DATEPART(MONTH, fecha_prestamo) AS Mes,
        COUNT(*) AS NumeroPrestamos
    FROM
        VistaInformacionBicicletas
    GROUP BY
        id_quiosco_entrada,
        DATEPART(MONTH, fecha_prestamo);

    PRINT ''; -- Salto de línea entre resultados

    -- Devolución por quioscos
    SELECT 'Devolución por quioscos' AS Titulo;
    SELECT
        id_quiosco_salida AS IdQuiosco,
        DATEPART(MONTH, fecha_devolucion) AS Mes,
        COUNT(*) AS NumeroDevoluciones
    FROM
        VistaInformacionBicicletas
    WHERE
        fecha_devolucion IS NOT NULL
    GROUP BY
        id_quiosco_salida,
        DATEPART(MONTH, fecha_devolucion);

    PRINT ''; -- Salto de línea entre resultados

    -- 10 Bicis más prestadas
    SELECT '10 Bicis más prestadas' AS Titulo;
    SELECT TOP 10
        placa,
        COUNT(*) AS veces_prestada,
		id_quiosco_salida
    FROM
        VistaInformacionBicicletas
    GROUP BY
        placa,
		id_quiosco_salida

    ORDER BY
        veces_prestada DESC;

    PRINT ''; -- Salto de línea entre resultados

    -- Rotación de bicis
    SELECT 'Rotación de bicis' AS Titulo;
    SELECT
        placa,
        id_quiosco_salida AS id_quiosco,
        COUNT(*) AS VecesSalida,
        COUNT(DISTINCT id_quiosco_entrada) AS VecesEntrada
    FROM
        VistaInformacionBicicletas
    WHERE
        id_quiosco_salida IS NOT NULL
    GROUP BY
        placa,
        id_quiosco_salida;

    COMMIT;
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED; -- Restablecer el nivel de aislamiento
END;

-- Ejecutar el procedimiento para presentar vistas
EXEC PresentarVistas;

-- Limpiar recursos
DROP PROCEDURE PresentarVistas;
DROP VIEW VistaInformacionBicicletas;

use BICIS2
