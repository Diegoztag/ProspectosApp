INSERT INTO
    cat_promotores(
        nom_nombre,
        nom_apellido_paterno,
        nom_apellido_materno,
        num_telefono
    )
VALUES (
        'Diego',
        'Zazueta',
        'Aguirre',
        '6677984583'
    ), (
        'Viridiana',
        'Romero',
        'Galvez',
        '667789568'
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
        'Juan',
        'Meza',
        'Antuna',
        '667895424',
        '14521785412'
    ), (
        2,
        'Jorge',
        'Esparza',
        'Enqriquez',
        '6674859658',
        '142598567854'
    );

INSERT INTO
    cat_direcciones(idu_prospecto, nom_calle, num_casa_ext, num_casa_int, nom_colonia, num_cp)
VALUES  (1, 'Isabel la catolica', 30, '2-B', 'Centro', 23400),
        (2, 'Libertad', 23, '0', 'Cañitas', 453333);

INSERT INTO
    ctl_permisos(
        idu_promotor,
        des_user,
        des_pass
    )
VALUES (1, 'user123', MD5('1234')), (2, 'userabc', MD5('abcd'));

INSERT INTO
    cat_documentos(idu_prospecto, nom_documento)
VALUES (1, 'Documento1'), (2, 'Documento2');

INSERT INTO
    cat_estatus(des_estatus)
VALUES ('Enviado'), ('Autorizado'), ('Rechazado');

INSERT INTO
    ctl_estatus(
        idu_prospecto,
        idu_cat_estatus,
        des_observacion
    )
VALUES (1, 1, ''), (2, 3, 'No pasó examen');
