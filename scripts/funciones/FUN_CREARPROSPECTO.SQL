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

