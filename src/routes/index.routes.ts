import { Router } from 'express'
import routerProspectos from './prospectos.routes'
import routerPromotores from './promotores.routes';

class Rutas {
    router: Router;

    constructor() {
        this.router = Router();
        this.router.use(routerProspectos);
        this.router.use(routerPromotores);
    }
}

export default new Rutas().router;