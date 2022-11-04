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
