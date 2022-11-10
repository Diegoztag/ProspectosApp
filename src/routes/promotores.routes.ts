import { Router } from 'express'
import { PromotoresController } from '../controllers/promotores.controller'

class RutasPromotores {
    public routerPromotores: Router;
    private promotoresController: PromotoresController;

    constructor() {
        this.promotoresController = new PromotoresController();
        this.routerPromotores = Router();
        this.routes();
    }

    private routes() {
        this.routerPromotores.get('/api/promotores', this.promotoresController.obtenerPromotores)
    }
}

export default new RutasPromotores().routerPromotores;