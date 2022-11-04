import { Router } from 'express'
import { ProspectosController } from '../controllers/prospectos.controllers'

class RutasProspectos {
    public routerProspectos: Router;
    private prospectosController: ProspectosController;

    constructor() {
        this.prospectosController = new ProspectosController();
        this.routerProspectos = Router();
        this.routes();
    }

    private routes() {
        this.routerProspectos.get('/api/prospectos', this.prospectosController.obtenerProspectos)
        this.routerProspectos.get('/api/prospectos/:id', this.prospectosController.obtenerProspecto)
        this.routerProspectos.post('/api/prospectos', this.prospectosController.crearProspecto)
        this.routerProspectos.put('/api/prospectos/:id', this.prospectosController.actualizarProspecto)
    }
}

export default new RutasProspectos().routerProspectos;