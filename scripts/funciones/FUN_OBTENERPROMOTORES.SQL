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
