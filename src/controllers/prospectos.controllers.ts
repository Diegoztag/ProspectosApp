import { Request, Response } from "express";
import { getLogger, Logger } from "log4js";
import dateFormat from "dateformat";
import { responseMeta } from "../source/setting/response";
import SequelizePG from "../source/database/connectionpg";
import { FUNCTIONS_PROSPECTOS } from "../source/queries/prospectos.queries";
import { IProspecto } from "../interfaces/prospecto.interface";
import { IDocumento } from "../interfaces/documento.interface";

export class ProspectosController {
    private logger: Logger;
    private now: Date;
    private completeDateFormat: string;
    private msgLog: string;

    constructor() {
        this.logger = getLogger();
        this.now = new Date();
        this.completeDateFormat = dateFormat(this.now, "yyyy-mm-dd HH:MM:ss.l");
        this.msgLog = `${this.completeDateFormat} --`;
    }

    public obtenerProspectos = async (req: Request, res: Response): Promise<void> => {
        let prospectos: IProspecto[];
        let queryParams = {
            idu_promotor: req.params.id
        }

        try {
            const [resultProspectos] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["obtener_prospectos"],
                { replacements: queryParams }
            );

            if (resultProspectos) {
                prospectos = resultProspectos as IProspecto[];

                res.status(200).json({
                    meta: responseMeta(200, "Lista de prospectos", "OK"),
                    data: prospectos,
                });
            } else {
                this.logger.error(`${this.msgLog} [RESPONSE QUERY]:: Lista de prospectos vacía}`);
                res.status(404).json({
                    meta: responseMeta(404, "Lista de prospectos vacía", "NO_CONTENT"),
                    data: null,
                });
            }
        } catch (error) {
            this.logger.error(`${this.msgLog} [FAIL]:: ${error}`);
            res.status(500).json({
                meta: responseMeta(500, "Error", "SERVER_ERROR"),
                data: null,
            });
        }
    }

    public obtenerProspecto = async (req: Request, res: Response): Promise<void> => {
        let prospecto: IProspecto;
        let documentos: IDocumento[];
        let queryParams = {
            idu_prospecto: req.params.id
        }

        try {
            const [resultProspecto] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["obtener_prospecto"],
                { replacements: queryParams }
            );

            if (resultProspecto) {
                prospecto = resultProspecto as IProspecto;

                const [resultProspectoDocs] = await SequelizePG.conn.query(
                    FUNCTIONS_PROSPECTOS["obtener_prospecto_docs"],
                    { replacements: queryParams }
                );

                if(resultProspectoDocs) {
                    documentos =  resultProspectoDocs as IDocumento[];

                    res.status(200).json({
                        meta: responseMeta(200, "Documentos de prospecto", "OK"),
                        data: [resultProspecto, resultProspectoDocs],
                    });
                }
            } else {
                this.logger.error(`${this.msgLog} [RESPONSE QUERY]:: Prospecto no encontrado}`);
                res.status(404).json({
                    meta: responseMeta(404, "Prospecto no encontrado", "NO_CONTENT"),
                    data: null,
                });
            }
        } catch (error) {
            this.logger.error(`${this.msgLog} [FAIL]:: ${error}`);
            res.status(500).json({
                meta: responseMeta(500, "Error", "SERVER_ERROR"),
                data: null,
            });
        }
    }

    public crearProspecto = async (req: Request, res: Response): Promise<void> => {
        let result: any;
        let queryParams = {
            idu_promotor: req.body.idu_promotor,
            nom_nombre: req.body.nom_nombre,
            nom_apellido_paterno: req.body.nom_apellido_paterno,
            nom_apellido_materno: req.body.nom_apellido_materno,
            num_telefono: req.body.num_telefono,
            num_rfc: req.body.num_rfc,
            nom_calle: req.body.nom_calle,
            num_casa_ext: req.body.num_casa_ext,
            num_casa_int: req.body.num_casa_int,
            nom_colonia: req.body.nom_colonia,
            num_cp: req.body.num_cp,
            idu_uuid: req.body.idu_uuid
        }

        try {
            const [resultCrearProspecto] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["crear_prospecto"],
                { replacements: queryParams }
            );
            result = resultCrearProspecto[0].fun_crearprospecto;

            if (result) {
                res.status(201).json({
                    meta: responseMeta(201, "Prospecto creado", "CREATED"),
                    data: result,
                });
            } else {
                res.status(201).json({
                    meta: responseMeta(201, "Ya existe un prospecto con este RFC", "NOT_CREATED"),
                    data: result,
                });
            }
        } catch (error) {
            this.logger.error(`${this.msgLog} [FAIL]:: ${error}`);
            res.status(500).json({
                meta: responseMeta(500, "Error", "SERVER_ERROR"),
                data: null,
            });
        }
    }

    public crearDocsProspecto = async (req: Request, res: Response): Promise<void> => {
        let result: any;
        let queryParams = {
            nom_documento: req.body.nom_documento,
            idu_uuid: req.body.idu_uuid
        }

        try {
            const [resultCrearDocsProspecto] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["crear_prospecto_docs"],
                { replacements: queryParams }
            );

            result = resultCrearDocsProspecto[0].fun_crearprospectodocumento;

            if (result) {
                res.status(201).json({
                    meta: responseMeta(201, "Documento registrado", "CREATED"),
                    data: result,
                });
            }
        } catch (error) {
            this.logger.error(`${this.msgLog} [FAIL]:: ${error}`);
            res.status(500).json({
                meta: responseMeta(500, "Error", "SERVER_ERROR"),
                data: null,
            });
        }
    }

    public actualizarProspecto = async (req: Request, res: Response): Promise<void> => {
        let result: any;
        let queryParams = {
            idu_prospecto: req.params.id,
            idu_cat_estatus: req.body.idu_cat_estatus,
            des_observacion: req.body.des_observacion
        };
        console.log(req.body)
        console.log(queryParams);

        try {
            const [resultActualizarProspecto] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["actualizar_prospecto"],
                { replacements: queryParams }
            );
            result = resultActualizarProspecto[0].fun_actualizarprospecto;

            if (result) {
                res.status(201).json({
                    meta: responseMeta(200, "Prospecto Actualizado", "OK"),
                    data: result,
                });
            }
        } catch (error) {
            this.logger.error(`${this.msgLog} [FAIL]:: ${error}`);
            res.status(500).json({
                meta: responseMeta(500, "Error", "SERVER_ERROR"),
                data: null,
            });
        }
    }

    public subirArchivoProspecto = async (__req: Request, res: Response): Promise<void> => {
        try {
            res.status(201).json({
                meta: responseMeta(201, "Archivo subido", "CREATED"),
                data: 1,
            });
        } catch (error) {
            this.logger.error(`${this.msgLog} [FAIL]:: ${error}`);
            res.status(500).json({
                meta: responseMeta(500, "Error", "SERVER_ERROR"),
                data: 0,
            });
        }
    }

    public bajarArchivoProspecto = async (req: Request, res: Response): Promise<void> => {
        try {
            res.download(`/home/app/build/public/uploads/${req.params.name}`,req.params.name, function(err){
                if(err){
                    res.status(404).json({
                        meta: responseMeta(404, "No se encontro el documento", "NOT_FOUND"),
                        data: null,
                    });
                }
            });
        } catch (error) {
            this.logger.error(`${this.msgLog} [FAIL]:: ${error}`);
            res.status(500).json({
                meta: responseMeta(500, "Error", "SERVER_ERROR"),
                data: null,
            });
        }
    }
}