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