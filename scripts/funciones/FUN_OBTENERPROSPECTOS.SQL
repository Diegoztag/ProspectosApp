CREATE OR REPLACE FUNCTION fun_obtenerlistadoprospectos()
-- ============================================= 
-- Autor: Diego Otniel Zazueta Aguirre 
-- Fecha: 01/11/22 
-- Descripción general: Obtiene la lista de prospectos totales 
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

GRANT EXECUTE ON FUNCTION fun_obtenerlistadoprospectos() TO diegoztag;

COMMENT ON FUNCTION fun_obtenerlistadoprospectos() IS 'Obtiene lista de prospectos';
