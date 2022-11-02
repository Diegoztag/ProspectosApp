CREATE TABLE
    cat_estatus (
        idu_estatus SERIAL NOT NULL,
        des_estatus VARCHAR(20) NOT NULL,
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_cat_estatus PRIMARY KEY (idu_estatus)
    );