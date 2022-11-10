import { Router } from 'express'
import { ProspectosController } from '../controllers/prospectos.controllers'
import uploadFile from '../source/setting/uploadFile';

class RutasProspectos {
    public routerProspectos: Router;
    private prospectosController: ProspectosController;

    constructor() {
        this.prospectosController = new ProspectosController();
        this.routerProspectos = Router();
        this.routes();
    }

    private routes() {
        this.routerProspectos.get('/api/prospectos/:id', this.prospectosController.obtenerProspectos)
        this.routerProspectos.get('/api/prospecto/:id', this.prospectosController.obtenerProspecto)
        this.routerProspectos.post('/api/prospecto', this.prospectosController.crearProspecto)
        this.routerProspectos.put('/api/prospecto/:id', this.prospectosController.actualizarProspecto)
        this.routerProspectos.post('/api/prospecto/files', uploadFile, this.prospectosController.subirArchivoProspecto)
        this.routerProspectos.get('/api/prospecto/files/:name', this.prospectosController.bajarArchivoProspecto)
        this.routerProspectos.post('/api/prospecto/docs', this.prospectosController.crearDocsProspecto)
    }
}

export default new RutasProspectos().routerProspectos;