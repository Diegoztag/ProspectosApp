
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
    num_cp INTEGER)
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
            num_rfc)
		VALUES 
            ($1,
            $2,
            $3,
            $4,
            $5,
            $6);

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
    num_cp INTEGER) TO diegoztag;

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
    num_cp INTEGER) IS 'Inserta o actualiza los datos del prospecto en las tablas correspondientes validandidando la existencia del prspecto por el rfc unico,
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
	num_cp = numero de codigo postal';


CREATE OR REPLACE FUNCTION fun_obtenerprospecto(idu INTEGER)
-- ============================================= 
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 03/11/22 
-- Descripción general: Obtiene los datos del prospecto seleccionado
-- ============================================= 
RETURNS TABLE(
	idu_prospecto INTEGER,
	nom_nombre VARCHAR,
	nom_apellido_paterno VARCHAR,
	nom_apellido_materno VARCHAR,
	des_estatus VARCHAR,
	des_observacion VARCHAR
) AS 
$BODY$ 
	BEGIN RETURN query
	SELECT
		cp.idu_prospecto,
	    cp.nom_nombre,
	    cp.nom_apellido_paterno,
	    cp.nom_apellido_materno,
	    cest.des_estatus,
	    ctle.des_observacion
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
		AND cp.idu_prospecto = $1;
	END;
$BODY$ 
	
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER; 

GRANT EXECUTE ON FUNCTION fun_obtenerprospecto(idu INTEGER) TO diegoztag;

COMMENT ON FUNCTION fun_obtenerprospecto(idu INTEGER) IS 'Obtiene los datos del prospecto seleccionado
idu = idu del prospecto';


CREATE OR REPLACE FUNCTION fun_obtenerprospectos()
-- ============================================= 
-- Autor: Diego Otniel Zazueta Aguirre
-- Fecha: 01/11/22 
-- Descripción general: Obtiene la lista de prospectos 
-- ============================================= 
RETURNS TABLE(
	idu_prospecto INTEGER,
	nom_nombre VARCHAR,
	nom_apellido_paterno VARCHAR,
	nom_apellido_materno VARCHAR,
	des_estatus VARCHAR
) AS 
$BODY$ 
	BEGIN RETURN query
	SELECT
		cp.idu_prospecto,
	    cp.nom_nombre,
	    cp.nom_apellido_paterno,
	    cp.nom_apellido_materno,
	    cest.des_estatus
	FROM cat_prospectos cp
	    INNER JOIN ctl_estatus ctle 
			ON cp.idu_prospecto = ctle.idu_prospecto
	    INNER JOIN cat_estatus cest 
			ON cest.idu_estatus = ctle.idu_cat_estatus
	WHERE
	    cp.idu_prospecto = ctle.idu_prospecto
	    AND cp.opc_cancelado = FALSE
	    AND ctle.opc_cancelado = FALSE
	    AND cest.opc_cancelado = FALSE;
	END;
$BODY$ 
	
LANGUAGE 'plpgsql' VOLATILE SECURITY DEFINER; 

GRANT EXECUTE ON FUNCTION fun_obtenerprospectos() TO diegoztag;

COMMENT ON FUNCTION fun_obtenerprospectos() IS 'Obtiene lista de prospectos';
