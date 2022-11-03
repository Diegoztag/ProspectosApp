CREATE TABLE
    cat_prospectos (
        idu_prospecto SERIAL NOT NULL,
        idu_promotor INTEGER NOT NULL,
        nom_nombre VARCHAR(25) NOT NULL,
        nom_apellido_paterno VARCHAR(25) NOT NULL,
        nom_apellido_materno VARCHAR(25) NOT NULL,
        num_telefono VARCHAR(15) NOT NULL,
        num_rfc VARCHAR(13) NOT NULL,
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_cat_prospectos PRIMARY KEY (idu_prospecto),
        CONSTRAINT fk_cat_prospectos_cat_promotores FOREIGN KEY (idu_promotor) REFERENCES cat_promotores (idu_promotor)
    );