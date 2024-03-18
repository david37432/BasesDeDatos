USE BICIS2;
CREATE PROCEDURE cargueMasivoRegistro
AS
BEGIN
    -- Operación de inserción masiva
    BULK INSERT registro
	FROM 'C:\\Users\\tavoe\\OneDrive\\Documentos\\Cuarto semestre\\Bases de datos\\DatosRegistroFinal.txt'  -- Especifica la ruta del archivo de texto
	WITH (
		FIELDTERMINATOR = ',',  -- Especifica el carácter que separa los campos en el archivo (en este caso, una coma)
		ROWTERMINATOR = '\' ,  -- Especifica el carácter de terminación de línea en el archivo (en este caso, un salto de línea)
		FIRSTROW = 0          -- Especifica la primera fila del archivo donde comienza la inserción (en este caso, la primera fila)
	);

    INSERT INTO estudiante (id_registro, id_universidad, telefono_emergencia)
    SELECT id_registro, 5000, numero_telefono
    FROM registro
    WHERE confirmacion_pago=1;
END;

DROP PROCEDURE cargueMasivoRegistro;
EXEC cargueMasivoRegistro;




CREATE PROCEDURE cargueMasivoBicis
AS
BEGIN
BULK INSERT bicicleta
FROM 'C:\Users\tavoe\OneDrive\Documentos\Cuarto semestre\Bases de datos\DatosBicis.txt'  -- Especifica la ruta del archivo de texto
WITH (
	FIELDTERMINATOR = ',',  -- Especifica el carácter que separa los campos en el archivo (en este caso, una coma)
	ROWTERMINATOR = '/' ,  -- Especifica el carácter de terminación de línea en el archivo (en este caso, un salto de línea)
	FIRSTROW = 1           -- Especifica la primera fila del archivo donde comienza la inserción (en este caso, la primera fila)
	);
	UPDATE bicicleta
	SET condiciones_actuales = SUBSTRING(condiciones_actuales, 2, LEN(condiciones_actuales) - 2)
	WHERE LEN(condiciones_actuales) > 2;
	UPDATE bicicleta
	SET condiciones_actuales = SUBSTRING(condiciones_actuales, 2, LEN(condiciones_actuales) - 0)
	WHERE LEN(condiciones_actuales) > 2;
	BULK INSERT quiosco_bicicleta
FROM 'C:\Users\tavoe\OneDrive\Documentos\Cuarto semestre\Bases de datos\quiosco_bici.txt'  -- Especifica la ruta del archivo de texto
WITH (
	FIELDTERMINATOR = ',',  -- Especifica el carácter que separa los campos en el archivo (en este caso, una coma)
	ROWTERMINATOR = '/' ,  -- Especifica el carácter de terminación de línea en el archivo (en este caso, un salto de línea)
	FIRSTROW = 1           -- Especifica la primera fila del archivo donde comienza la inserción (en este caso, la primera fila)
	);
	EXEC ActualizarCantidadBicicleta;
	EXEC ActualizarBloqueosBici;
END;
DROP PROCEDURE cargueMasivoBicis;


EXEC cargueMasivoBicis;
SELECT condiciones_actuales FROM bicicleta;




CREATE PROCEDURE cargueQuioscoBicicleta
AS
BEGIN
    -- Operación de inserción masiva
    BULK INSERT hoja_prestamo
	FROM 'C:\Users\tavoe\OneDrive\Documentos\Cuarto semestre\Bases de datos\hoja.txt'  -- Especifica la ruta del archivo de texto
	WITH (
		FIELDTERMINATOR = ',',  -- Especifica el carácter que separa los campos en el archivo (en este caso, una coma)
		ROWTERMINATOR = '\' ,  -- Especifica el carácter de terminación de línea en el archivo (en este caso, un salto de línea)
		FIRSTROW = 0          -- Especifica la primera fila del archivo donde comienza la inserción (en este caso, la primera fila)
	);
	DELETE q
	FROM quiosco_bicicleta q
	INNER JOIN hoja_prestamo h ON q.placa = h.placa
	WHERE h.placa IS NOT NULL;
	INSERT INTO quiosco_bicicleta (id_quiosco, placa, estado)
	SELECT id_quiosco_entrada, placa, 0
	FROM hoja_prestamo
	WHERE id_quiosco_entrada IS NOT NULL;
	EXEC ActualizarCantidadBicicleta;
	WITH condiconesPrestamo AS(SELECT placa,condiciones_devolucion FROM hoja_prestamo)
	UPDATE bicicleta
	SET condiciones_actuales=condiconesPrestamo.condiciones_devolucion
	FROM condiconesPrestamo
	WHERE bicicleta.placa=condiconesPrestamo.placa;
	EXEC ActualizarBloqueosBici;
END;
DROP PROCEDURE cargueQuioscoBicicleta;
EXEC cargueQuioscoBicicleta;






DELETE FROM bicicleta;
DELETE FROM quiosco_bicicleta;
DELETE FROM hoja_prestamo;
SELECT * FROM hoja_prestamo
WHERE placa=20167329;
SELECT * FROM bicicleta
WHERE placa=20167329;
SELECT * FROM quiosco_bicicleta
WHERE placa=20167329;

DROP TRIGGER IF EXISTS  tr_ActualizarEstadoQuioscoBicicleta;
/*pruebas para el trigger*/
INSERT INTO hoja_prestamo (id_prestamo, placa, id_estudiante, fecha_prestamo, condiciones_iniciales, condiciones_devolucion, id_quiosco_salida, id_quiosco_entrada, fecha_devolucion)
VALUES
(30000252, 20000002, 10249409, '1/7/2020', (SELECT condiciones_actuales FROM bicicleta WHERE placa=20000002), NULL, (SELECT id_quiosco FROM quiosco_bicicleta WHERE placa=20000002), NULL, NULL);
DELETE FROM hoja_prestamo WHERE id_prestamo=30000252;
UPDATE hoja_prestamo
SET
	condiciones_devolucion='pesimo',
	id_quiosco_entrada=13005,
	fecha_devolucion='1/17/2020'
WHERE  id_prestamo=30000252;
UPDATE quiosco_bicicleta SET estado=0 WHERE placa=20000002;
SELECT * FROM hoja_prestamo WHERE id_prestamo=30000252;
SELECT * FROM quiosco_bicicleta WHERE placa=20000002;
SELECT * FROM bicicleta WHERE placa=20000002;


CREATE TRIGGER tr_ActualizarEstadoQuioscoBicicleta--activadoooooooooooo
ON hoja_prestamo
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
    IF UPDATE(id_quiosco_entrada)
    BEGIN
        UPDATE qb
        SET qb.estado = 0, qb.id_quiosco=i.id_quiosco_entrada
        FROM quiosco_bicicleta qb
		INNER JOIN inserted i ON qb.placa = i.placa;
		EXEC ActualizarCantidadBicicleta;

		UPDATE b
		SET b.condiciones_actuales=i.condiciones_devolucion
		FROM bicicleta b
		INNER JOIN inserted i ON b.placa = i.placa;
    END;
END;
DROP TRIGGER tr_ActualizarEstadoQuioscoBicicleta
/*no deja que se elimine una cicla del inventario la cual esta en prestamo activo*/
INSERT quiosco_bicicleta(id_quiosco,placa,estado) VALUES (13004,20000002,1);--por si acaso fallaba xd (no lo hizo pero igual lo dejo)
DELETE FROM quiosco_bicicleta WHERE placa=20000002;--la prueba de que si funciono perfectamenteeeeeeeeee





CREATE TRIGGER trg_PrevenirEliminacionBici
ON quiosco_bicicleta
INSTEAD OF DELETE
AS
BEGIN
    -- Verificar si hay registros con estado igual a 1 en la tabla deleted
    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE d.estado = 1
    )
    BEGIN
        RAISERROR('No se puede realizar la eliminación mientras esta la cicla en prestamo.', 16, 1);
    END
    ELSE
    BEGIN
        -- Eliminar los registros si no hay registros con estado igual a 1
        DELETE FROM quiosco_bicicleta
        WHERE EXISTS (
            SELECT 1
            FROM deleted d
            WHERE quiosco_bicicleta.placa = d.placa
        );
    END;
END;
DROP TRIGGER trg_PrevenirEliminacionEstado1
/*no permitira que se inserte una bici ya insertada en la tabla*/



CREATE TRIGGER trg_QuiscobBicicleta_EstadoUnico
ON quiosco_bicicleta
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN quiosco_bicicleta qb ON i.placa = qb.placa
    )
    BEGIN
        RAISERROR('No se puede realizar el INSERT. La placa ya está registrada en la tabla quiosco_bicicleta.', 16, 1);
    END
    ELSE
    BEGIN
        -- Insertar los registros si no hay placas duplicadas
        INSERT INTO quiosco_bicicleta (id_quiosco, placa, estado)
        SELECT id_quiosco, placa, estado
        FROM inserted;
		EXEC ActualizarCantidadBicicleta;
    END;
END;




/*experimentos del triger denegar prestamo*/
INSERT INTO hoja_prestamo (id_prestamo, placa, id_estudiante, fecha_prestamo, condiciones_iniciales, condiciones_devolucion, id_quiosco_salida, id_quiosco_entrada, fecha_devolucion)
VALUES
(30000252, 20000002, 10249409, '1/7/2020', (SELECT condiciones_actuales FROM bicicleta WHERE placa=20000002), NULL, (SELECT id_quiosco FROM quiosco_bicicleta WHERE placa=20000002), NULL, NULL);
DELETE FROM hoja_prestamo WHERE id_prestamo=30000252;
DELETE FROM quiosco_bicicleta WHERE placa=20000002 and estado=0;
SELECT placa,condiciones_actuales, bloqueo FROM bicicleta WHERE condiciones_actuales='pesimo';
SELECT * FROM hoja_prestamo WHERE id_prestamo=30000252
SELECT * FROM quiosco_bicicleta WHERE  placa=20000002;
UPDATE quiosco_bicicleta SET estado=0 WHERE placa=20000464;
INSERT quiosco_bicicleta(id_quiosco,placa,estado) VALUES(13000,20000400,0);
/*pendiente por hacer esta re puta mrd (ya nooooooooooo vida hpta al fiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiin jueputa lo logreeeeee a las 4am)*/



CREATE TRIGGER trg_DenegarPrestamo
ON hoja_prestamo
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN bicicleta b ON i.placa = b.placa
        WHERE b.bloqueo = 1
            OR (
                EXISTS (
                    SELECT 1
                    FROM quiosco_bicicleta qb
                    WHERE (i.placa = qb.placa AND qb.estado = 1) OR (i.id_quiosco_salida = qb.id_quiosco AND qb.estado = 1)
                )
            )
    )
    BEGIN
        RAISERROR ('No se puede realizar la operación. La bicicleta está dañada o ya está prestada o el quiosco tiene un préstamo activo.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
	ELSE
    BEGIN
        UPDATE quiosco_bicicleta
		SET estado=1
		WHERE EXISTS(
			SELECT 1
			FROM inserted i
			WHERE i.placa = quiosco_bicicleta.placa
			AND i.id_quiosco_salida = quiosco_bicicleta.id_quiosco
		)
    END;
END;
DROP TRIGGER trg_DenegarPrestamo;
/*AQUI VAN LOS NUEVOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOS*/

/*procedimiento que actualiza cantidad_bicicleta en la tabla quiosco*/



CREATE PROCEDURE ActualizarCantidadBicicleta
AS
BEGIN
    -- Actualizar la cantidad de bicicletas en cada quiosco
    UPDATE q
    SET cantidad_bicicleta = COALESCE(cantidad, 0)
    FROM quiosco q
    LEFT JOIN (
        SELECT id_quiosco, COUNT(*) AS cantidad
        FROM quiosco_bicicleta
        WHERE estado = 0
        GROUP BY id_quiosco
    ) qb ON q.id_quiosco = qb.id_quiosco;
END;
DROP PROCEDURE ActualizarCantidadBicicleta;
EXEC ActualizarCantidadBicicleta;
/*cantidad de bicicletas en total*/
SELECT SUM(cantidad_bicicleta) AS total_bicicletas
FROM quiosco;




/*actualizar bloqueos de bicis*/
CREATE PROCEDURE ActualizarBloqueosBici
AS
BEGIN
	UPDATE bicicleta
	SET bloqueo = 1
	WHERE condiciones_actuales = 'pesimo';
	UPDATE bicicleta
	SET bloqueo = 0
	WHERE condiciones_actuales <> 'pesimo';
END;
/*trigger para insert de bicis*/




CREATE TRIGGER RectificarBloqueos
ON bicicleta
AFTER INSERT, UPDATE
AS
BEGIN
    EXEC ActualizarBloqueosBici;
END;

CREATE TRIGGER tr_no_prestamo_sin_pago
ON hoja_prestamo
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN registro r ON i.id_estudiante = r.id_registro
        WHERE r.confirmacion_pago = 0
    )
    BEGIN
        RAISERROR ('No se puede prestar una bicicleta a un estudiante con confirmación de pago igual a 0.', 16, 1)
        ROLLBACK TRANSACTION;
    END
END;