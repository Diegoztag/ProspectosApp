import { Request, Response } from "express";
import { getLogger, Logger } from "log4js";
import dateFormat from "dateformat";
import { responseMeta } from "../source/setting/response";
import SequelizePG from "../source/database/connectionpg";
import { FUNCTIONS_PROSPECTOS } from "../source/queries/prospectos.queries";
import { IProspecto } from "../source/interfaces/prospecto.interface";

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

    public obtenerProspectos = async (__req: Request, res: Response) => {
        let prospectos: IProspecto[];

        try {
            const [resultProspectosList] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["obtener_prospectos"]
            );

            if (resultProspectosList) {
                prospectos = resultProspectosList as IProspecto[];

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

    public obtenerProspecto = async (req: Request, res: Response) => {
        let prospecto: IProspecto;
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

                res.status(200).json({
                    meta: responseMeta(200, "Lista de prospectos", "OK"),
                    data: prospecto,
                });
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

    public crearProspecto = async (req: Request, res: Response) => {
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
            num_cp: req.body.num_cp
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

    // public evaluarProspectos = async (req: Request, res: Response) => {
    // }

}