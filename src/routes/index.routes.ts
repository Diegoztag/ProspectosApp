import { Router } from 'express'
import routerProspectos from './prospectos.routes'

class Rutas {
    router: Router;

    constructor() {
        this.router = Router();
        this.router.use(routerProspectos);
    }
}

export default new Rutas().router;