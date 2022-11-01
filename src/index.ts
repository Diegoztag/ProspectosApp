import express from 'express'
import morgan from 'morgan'
import compression from 'compression'
import cors from 'cors'
import config from "./source/setting/config"

class Server {
  app: express.Application;

  constructor() {
    this.app = express();
    this.config();
  }

  private config() {
    //Settings
    this.app.set('port', config.port);

    //Middlewares
    this.app.use(morgan('dev'));
    this.app.use(cors());
    this.app.use(compression());
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
  }

  public start() {
    try {
       this.app.listen(this.app.get('port'), () => {
        console.log(`Servidor en el puerto ${this.app.get('port')}`)
      })
    } catch (error) {
      console.log(error);
    }
  }
}

const server = new Server();
server.start();