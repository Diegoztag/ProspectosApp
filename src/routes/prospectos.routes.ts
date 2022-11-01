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
        this.routerProspectos.post('/api/v1/prospectos/crear', this.prospectosController.crearProspecto)
        this.routerProspectos.get('/api/v1/prospectos/obtener',this.prospectosController.obtenerListaProspectos)
        this.routerProspectos.get('/api/v1/prospectos/evaluar',this.prospectosController.evaluarProspectos)
    }
}

export default new RutasProspectos().routerProspectos;