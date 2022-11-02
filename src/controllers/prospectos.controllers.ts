import { Request, Response } from "express";
import { getLogger, Logger } from "log4js";
import dateFormat from "dateformat";
import { responseMeta } from "../source/setting/response";
import SequelizePG from "../source/database/connectionpg";
import { FUNCTIONS_PROSPECTOS } from "../source/queries/prospectos.queries";
import { IProspectos } from "../source/interfaces/prospectos.interface";

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

    // public crearProspecto = async (req: Request, res: Response) => {
    // }

    public obtenerListaProspectos = async (__req: Request, res: Response) => {
        let prospectos: IProspectos[];

        try {
            const [resultProspectosList] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["obtener_listado_prospectos"]
            );

            if (resultProspectosList) {
                prospectos = resultProspectosList as IProspectos[];

                res.status(200).json({
                    meta: responseMeta(200, "Lista de prospectos", "OK"),
                    data: prospectos,
                });
            } else {
                this.logger.error(`${this.msgLog} [RESPONSE QUERY]:: Lista de prospectos vacía: 0}`);
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

    // public evaluarProspectos = async (req: Request, res: Response) => {
    // }

}