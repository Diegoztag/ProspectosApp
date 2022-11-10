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

