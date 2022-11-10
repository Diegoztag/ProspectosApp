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
