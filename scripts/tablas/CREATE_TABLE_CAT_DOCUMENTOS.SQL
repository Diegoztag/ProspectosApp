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