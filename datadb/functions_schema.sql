CREATE OR REPLACE FUNCTION fun_actualizarprospecto(
    idu INTEGER,
    idu_cat_estatus INTEGER,
    des_observacion CHARACTER
)
-- =============================================
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 03/11/2022
-- Descripción General: Actualiza datos del prospecto
-- =============================================
RETURNS INTEGER AS

$BODY$
BEGIN
	--Si existe el prospecto en la tabla ctl_estatus
	IF EXISTS (SELECT idu_prospecto
				FROM ctl_estatus ce
					WHERE ce.idu_prospecto = $1
						AND opc_cancelado = FALSE)
	THEN

		UPDATE ctl_estatus SET
            idu_cat_estatus = $2,
            des_observacion = $3
                WHERE idu_prospecto = $1
                    AND opc_cancelado = FALSE;

		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

END;
$BODY$

LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;

GRANT execute ON FUNCTION fun_actualizarprospecto(
    idu INTEGER,
    idu_cat_estatus INTEGER,
    des_observacion CHARACTER
) TO diegoztag;

COMMENT ON FUNCTION fun_actualizarprospecto(
    idu INTEGER,
    idu_cat_estatus INTEGER,
    des_observacion CHARACTER) IS 'Actualiza los datos del prospecto en las tablas correspondientes validandidando la existencia del estatus del prospecto,
	idu = idu prospecto,
    idu_cat_estatus = idu del estatus del prospecto,
    des_observacion = descripcion del estatus
';


CREATE OR REPLACE FUNCTION fun_crearprospecto(
    idu_promotor INTEGER,
    nom_nombre CHARACTER,
    nom_apellido_paterno CHARACTER,
    nom_apellido_materno CHARACTER,
    num_telefono CHARACTER,
    num_rfc CHARACTER,
    nom_calle CHARACTER,
    num_casa_ext INTEGER,
    num_casa_int CHARACTER,
    nom_colonia CHARACTER,
    num_cp INTEGER,
    idu_uuid CHARACTER)
-- =============================================
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 01/11/2022
-- Descripción General: Inserta o actualiza datos del prospecto
-- =============================================
RETURNS INTEGER AS

$BODY$
BEGIN
	--Si no existe el prospecto en la tabla cat_prospecto
	IF NOT EXISTS (SELECT idu_prospecto
				FROM cat_prospectos cp
					WHERE cp.num_rfc = $6
						AND opc_cancelado = FALSE)
	THEN

		INSERT INTO cat_prospectos
            (idu_promotor,
            nom_nombre,
            nom_apellido_paterno,
            nom_apellido_materno,
            num_telefono,
            num_rfc,
            idu_uuid)
		VALUES 
            ($1,
            $2,
            $3,
            $4,
            $5,
            $6,
            $12);

        INSERT INTO cat_direcciones
            (idu_prospecto,
            nom_calle,
            num_casa_ext,
            num_casa_int,
            nom_colonia,
            num_cp)
        VALUES (
            (SELECT idu_prospecto FROM cat_prospectos cp WHERE cp.num_rfc = $6),
            $7,
            $8,
            $9,
            $10,
            $11);

        INSERT INTO ctl_estatus
            (idu_prospecto)
        VALUES (
            (SELECT idu_prospecto FROM cat_prospectos cp WHERE cp.num_rfc = $6)
            );

		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

END;
$BODY$

LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;

GRANT execute ON FUNCTION fun_crearprospecto(
    idu_promotor INTEGER,
    nom_nombre CHARACTER,
    nom_apellido_paterno CHARACTER,
    nom_apellido_materno CHARACTER,
    num_telefono CHARACTER,
    num_rfc CHARACTER,
    nom_calle CHARACTER,
    num_casa_ext INTEGER,
    num_casa_int CHARACTER,
    nom_colonia CHARACTER,
    num_cp INTEGER,
    idu_uuid CHARACTER) TO diegoztag;

COMMENT ON FUNCTION fun_crearprospecto(
    idu_promotor INTEGER,
    nom_nombre CHARACTER,
    nom_apellido_paterno CHARACTER,
    nom_apellido_materno CHARACTER,
    num_telefono CHARACTER,
    num_rfc CHARACTER,
    nom_calle CHARACTER,
    num_casa_ext INTEGER,
    num_casa_int CHARACTER,
    nom_colonia CHARACTER,
    num_cp INTEGER,
    idu_uuid CHARACTER) IS 'Inserta o actualiza los datos del prospecto en las tablas correspondientes validandidando la existencia del prspecto por el rfc unico,
	idu_promotor = idu del promotor que registro al prospecto,
	nom_nombre = nombre del prospecto,
	nom_apellido_paterno = apellido paterno,
	nom_apellido_materno = apellido materno,
	num_telefono = numero telefonico,
	num_rfc = RFC,
	nom_calle = calle,
	num_casa_ext = numero de casa,
	num_casa_int = numero interior,
	nom_colonia = nombre colonia,
	num_cp = numero de codigo postal
    idu_uuid = idu generico';

CREATE OR REPLACE FUNCTION fun_crearprospectodocumento(
    nom_documento CHARACTER,
    idu_uuid CHARACTER)
-- =============================================
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 01/11/2022
-- Descripción General: Inserta datos del documento por prospecto
-- =============================================
RETURNS INTEGER AS

$BODY$
BEGIN
    INSERT INTO cat_documentos
        (idu_prospecto,
        nom_documento)
    SELECT 
        cp.idu_prospecto,
        $1
        FROM
            cat_prospectos cp
        WHERE cp.idu_uuid = $2;

    RETURN 1;
END;
$BODY$

LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER;

GRANT execute ON FUNCTION fun_crearprospectodocumento(
    nom_documento CHARACTER,
    idu_uuid CHARACTER) TO diegoztag;

COMMENT ON FUNCTION fun_crearprospectodocumento(
    nom_documento CHARACTER,
    idu_uuid CHARACTER) IS 
    'Inserta datos del documento por prospecto,
	nom_documento = nombre del documento,
    idu_uuid = idu temporal de control';
	
CREATE OR REPLACE FUNCTION fun_obtenerpromotores()
-- ============================================= 
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 03/11/22 
-- Descripción general: Obtiene lista de los promotores
-- ============================================= 
RETURNS TABLE(
	idu_promotor INTEGER,
	nom_nombre VARCHAR,
	nom_apellido_paterno VARCHAR,
	nom_apellido_materno VARCHAR
) AS 
$BODY$ 
	BEGIN RETURN query
	SELECT
	    cp.idu_promotor,
	    cp.nom_nombre,
	    cp.nom_apellido_paterno,
	    cp.nom_apellido_materno
	FROM cat_promotores cp
		WHERE cp.opc_cancelado = FALSE;
	END;
$BODY$ 
	
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER; 

GRANT EXECUTE ON FUNCTION fun_obtenerpromotores() TO diegoztag;

COMMENT ON FUNCTION fun_obtenerpromotores() IS 'Obtiene los datos de los promotores';


CREATE OR REPLACE FUNCTION fun_obtenerprospecto(idu INTEGER)
-- ============================================= 
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 03/11/22 
-- Descripción general: Obtiene los datos del prospecto seleccionado
-- ============================================= 
RETURNS TABLE(
	idu_prospecto INTEGER,
	idu_promotor INTEGER,
	nom_nombre VARCHAR,
	nom_apellido_paterno VARCHAR,
	nom_apellido_materno VARCHAR,
	nom_calle VARCHAR,
	num_casa_ext INTEGER,
	num_casa_int VARCHAR,
	nom_colonia VARCHAR,
	num_cp INTEGER,
	num_telefono VARCHAR,
	num_rfc VARCHAR,
	des_estatus VARCHAR,
	idu_cat_estatus INTEGER,
	des_observacion VARCHAR
) AS 
$BODY$ 
	BEGIN RETURN query
	SELECT
		cp.idu_prospecto,
		cp.idu_promotor,
	    cp.nom_nombre,
	    cp.nom_apellido_paterno,
	    cp.nom_apellido_materno,
		cd.nom_calle,
		cd.num_casa_ext,
		cd.num_casa_int,
		cd.nom_colonia,
		cd.num_cp,
		cp.num_telefono,
		cp.num_rfc,
	    cest.des_estatus,
		ctle.idu_cat_estatus,
	    ctle.des_observacion
	FROM cat_prospectos cp
	    INNER JOIN ctl_estatus ctle 
			ON cp.idu_prospecto = ctle.idu_prospecto
		INNER JOIN cat_direcciones cd
			ON cd.idu_prospecto = cp.idu_prospecto
	    INNER JOIN cat_estatus cest 
			ON cest.idu_estatus = ctle.idu_cat_estatus
	WHERE
	    cp.idu_prospecto = ctle.idu_prospecto
	    AND cp.opc_cancelado = FALSE
	    AND ctle.opc_cancelado = FALSE
	    AND cest.opc_cancelado = FALSE
		AND cp.idu_prospecto = $1;
	END;
$BODY$ 
	
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER; 

GRANT EXECUTE ON FUNCTION fun_obtenerprospecto(idu INTEGER) TO diegoztag;

COMMENT ON FUNCTION fun_obtenerprospecto(idu INTEGER) IS 'Obtiene los datos del prospecto seleccionado
idu = idu del prospecto';

CREATE OR REPLACE FUNCTION fun_obtenerprospectodocumentos(idu INTEGER)
-- ============================================= 
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 03/11/22 
-- Descripción general: Obtiene los documentos del prospecto seleccionado
-- ============================================= 
RETURNS TABLE(
    idu_documento INTEGER,
	idu_prospecto INTEGER,
	nom_documento VARCHAR
) AS 
$BODY$ 
	BEGIN RETURN query
	SELECT
        cd.idu_documento,
		cd.idu_prospecto,
	    cd.nom_documento
	FROM 
        cat_documentos cd
	WHERE
	    cd.opc_cancelado = FALSE
		AND cd.idu_prospecto = $1;
	END;
$BODY$ 
	
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER; 

GRANT EXECUTE ON FUNCTION fun_obtenerprospectodocumentos(idu INTEGER) TO diegoztag;

COMMENT ON FUNCTION fun_obtenerprospectodocumentos(idu INTEGER) IS 'Obtiene los datos del prospecto seleccionado
idu = idu del prospecto';

CREATE OR REPLACE FUNCTION fun_obtenerprospectos(idu_promotor INTEGER)
-- ============================================= 
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 03/11/22 
-- Descripción general: Obtiene los datos de los prospectos por promotor seleccionado
-- ============================================= 
RETURNS TABLE(
	idu_prospecto INTEGER,
	nom_nombre VARCHAR,
	nom_apellido_paterno VARCHAR,
	nom_apellido_materno VARCHAR,
	des_estatus VARCHAR,
	idu_cat_estatus INTEGER,
	des_observacion VARCHAR,
	fec_creado TIMESTAMP
) AS 
$BODY$ 
	BEGIN RETURN query
	SELECT
	    cp.idu_prospecto,
	    cp.nom_nombre,
	    cp.nom_apellido_paterno,
	    cp.nom_apellido_materno,
	    cest.des_estatus,
	    ctle.idu_cat_estatus,
	    ctle.des_observacion,
		cp.fec_creado
	FROM cat_prospectos cp
	    INNER JOIN ctl_estatus ctle 
			ON cp.idu_prospecto = ctle.idu_prospecto
	    INNER JOIN cat_estatus cest 
			ON cest.idu_estatus = ctle.idu_cat_estatus
	WHERE
	    cp.idu_prospecto = ctle.idu_prospecto
	    AND cp.opc_cancelado = FALSE
	    AND ctle.opc_cancelado = FALSE
	    AND cest.opc_cancelado = FALSE
		AND cp.idu_promotor = $1;
	END;
$BODY$ 
	
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER; 

GRANT EXECUTE ON FUNCTION fun_obtenerprospectos(idu_promotor INTEGER) TO diegoztag;

COMMENT ON FUNCTION fun_obtenerprospectos(idu_promotor INTEGER) IS 'Obtiene los datos de los prospectos
idu_promotor= promotor seleccionado';

