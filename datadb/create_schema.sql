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

CREATE TABLE
    cat_documentos (
        idu_documento SERIAL NOT NULL,
        idu_prospecto INTEGER NOT NULL,
        nom_documento VARCHAR(50) NOT NULL,
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_cat_documentos PRIMARY KEY (idu_documento),
        CONSTRAINT fk_cat_documentos_cat_prospectos FOREIGN KEY (idu_prospecto) REFERENCES cat_prospectos (idu_prospecto)
    );

CREATE TABLE
    cat_estatus (
        idu_estatus SERIAL NOT NULL,
        des_estatus VARCHAR(20) NOT NULL,
        opc_cancelado BOOLEAN NOT NULL DEFAULT FALSE,
        fec_creado TIMESTAMP NOT NULL DEFAULT NOW(),
        fec_modificado TIMESTAMP NOT NULL DEFAULT NOW(),
        CONSTRAINT pk_cat_estatus PRIMARY KEY (idu_estatus)
    );

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
