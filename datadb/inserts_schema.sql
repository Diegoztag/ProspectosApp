INSERT INTO
    cat_promotores(
        nom_nombre,
        nom_apellido_paterno,
        nom_apellido_materno,
        num_telefono
    )
VALUES (
        'DIEGO',
        'ZAZUETA',
        'AGUIRRE',
        '1'
    ), (
        'VIRIDIANA',
        'ROMERO',
        'GALVEZ',
        '2'
    );

INSERT INTO
    cat_prospectos(
        idu_promotor,
        nom_nombre,
        nom_apellido_paterno,
        nom_apellido_materno,
        num_telefono,
        num_rfc
    )
VALUES (
        1,
        'JUAN',
        'MEZA',
        'ANTUNA',
        '667895424',
        '14521785412'
    ), (
        2,
        'JORGE',
        'ESPARZA',
        'ENRIQUEZ',
        '6674859658',
        '142598567854'
    ), (
        3,
        'LUIS',
        'GUZMAN',
        'ENRIQUEZ',
        '6677986285',
        '13452345AS'
    );

INSERT INTO
    cat_direcciones(idu_prospecto, nom_calle, num_casa_ext, num_casa_int, nom_colonia, num_cp)
VALUES  (1, 'ISABEL LA CATOLIA', 30, '2-B', 'CENTRO', 23400),
        (2, 'LIBERTAD', 23, '0', '21 DE MARZO', 453333);

INSERT INTO
    cat_estatus(des_estatus)
VALUES ('ENVIADO'), ('AUTORIZADO'), ('RECHAZADO');

INSERT INTO
    ctl_estatus(
        idu_prospecto,
        idu_cat_estatus,
        des_observacion
    )
VALUES (1, 1, ''), (2, 2, ''), (3,3,'FALTA DOCUMENTOS');
