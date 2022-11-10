import { Request, Response } from "express";
import { getLogger, Logger } from "log4js";
import dateFormat from "dateformat";
import { responseMeta } from "../source/setting/response";
import SequelizePG from "../source/database/connectionpg";
import { FUNCTIONS_PROSPECTOS } from "../source/queries/prospectos.queries";
import { IPromotor } from "../interfaces/promotor.interface";

export class PromotoresController {
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

    public obtenerPromotores = async (__req: Request, res: Response): Promise<void> => {
        let promotores: IPromotor[];

        try {
            const [resultPromotores] = await SequelizePG.conn.query(
                FUNCTIONS_PROSPECTOS["obtener_promotores"]
            );

            if (resultPromotores) {
                promotores = resultPromotores as IPromotor[];

                res.status(200).json({
                    meta: responseMeta(200, "Lista de promotores", "OK"),
                    data: promotores,
                });
            } else {
                this.logger.error(`${this.msgLog} [RESPONSE QUERY]:: Lista de promotores vacía}`);
                res.status(404).json({
                    meta: responseMeta(404, "Lista de promotores vacía", "NO_CONTENT"),
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
}