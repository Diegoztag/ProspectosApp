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