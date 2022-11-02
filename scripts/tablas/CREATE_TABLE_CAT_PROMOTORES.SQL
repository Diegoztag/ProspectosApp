CREATE TABLE
    cat_promotores (
        idu_promotor SERIAL NOT NULL,
        nom_nombre VARCHAR(25) NOT NULL,
        nom_apellido_paterno VARCHAR(25) NOT NULL,
        nom_apellido_materno VARCHAR(25) NOT NULL,
        num_telefono VARCHAR(15) NOT NULL,
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_cat_promotores PRIMARY KEY (idu_promotor)
    );