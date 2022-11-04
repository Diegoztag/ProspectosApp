CREATE TABLE
    ctl_permisos (
        idu_permiso SERIAL NOT NULL,
        idu_promotor INTEGER NOT NULL,
        des_user VARCHAR(15) NOT NULL,
        des_pass VARCHAR(100) NOT NULL,
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_ctl_permisos PRIMARY KEY (idu_permiso),
        CONSTRAINT fk_ctl_permisos_cat_promotores FOREIGN KEY (idu_promotor) REFERENCES cat_promotores (idu_promotor)
    );