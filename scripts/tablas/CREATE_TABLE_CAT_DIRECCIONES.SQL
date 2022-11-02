CREATE TABLE
    cat_direcciones (
        idu_direccion SERIAL NOT NULL,
        idu_prospecto INTEGER NOT NULL,
        nom_calle VARCHAR(30) NOT NULL,
        num_casa_ext INTEGER NOT NULL,
        num_casa_int VARCHAR(5) NOT NULL DEFAULT '0',
        nom_colonia VARCHAR(30) NOT NULL,
        num_cp INTEGER NOT NULL,
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_cat_direciones PRIMARY KEY (idu_direccion),
        CONSTRAINT fk_cat_direcciones_cat_prospectos FOREIGN KEY (idu_prospecto) REFERENCES cat_prospectos (idu_prospecto)
    );