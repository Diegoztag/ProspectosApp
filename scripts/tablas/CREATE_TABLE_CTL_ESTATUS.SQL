CREATE TABLE
    ctl_estatus (
        idu_estatus SERIAL NOT NULL,
        idu_prospecto INTEGER NOT NULL,
        idu_cat_estatus INTEGER NOT NULL DEFAULT 1,
        des_observacion VARCHAR(100) NOT NULL DEFAULT '',
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_ctl_estatus PRIMARY KEY (idu_estatus),
        CONSTRAINT fk_ctl_estatus_cat_prospectos FOREIGN KEY (idu_prospecto) REFERENCES cat_prospectos (idu_prospecto),
        CONSTRAINT fk_ctl_estatus_cat_estatus FOREIGN KEY (idu_cat_estatus) REFERENCES cat_estatus (idu_estatus)
    );