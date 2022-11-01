import express from 'express'
import morgan from 'morgan'
import compression from 'compression'
import cors from 'cors'
import config from "./source/setting/config"
import SequelizePg from './source/database/connectionpg'
import { configure } from 'log4js'

class Server {
  app: express.Application;

  constructor() {
    this.app = express();
    this.config();
    this.sources();
    this.log();
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

  private async sources() {
    //Databases
    await SequelizePg.conexion();
  }

  private log() {
    configure({
      appenders: {
        app: { type: 'file', filename: 'logs/app.log' },
        out: { type: 'stdout' },
      },
      categories: {
        default: {
          appenders: ['app', 'out'],
          level: 'error'
        }
      }
    })
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