export const FUNCTIONS_PROSPECTOS = {
    obtener_prospectos: "select * from fun_obtenerprospectos()",
    obtener_prospecto: "select * from fun_obtenerprospecto(:idu_prospecto)",
    crear_prospecto: "select * from fun_crearprospecto(:idu_promotor,:nom_nombre,:nom_apellido_paterno,:nom_apellido_materno,:num_telefono,:num_rfc,:nom_calle,:num_casa_ext,:num_casa_int,:nom_colonia,:num_cp)",
    actualizar_prospecto: "select * from fun_actualizarprospecto(:idu_prospecto,:idu_cat_estatus,:des_observacion)",
}