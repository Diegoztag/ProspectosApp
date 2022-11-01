"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const morgan_1 = __importDefault(require("morgan"));
const compression_1 = __importDefault(require("compression"));
const cors_1 = __importDefault(require("cors"));
const index_routes_1 = __importDefault(require("./routes/index.routes"));
const https_1 = __importDefault(require("https"));
const fs_1 = __importDefault(require("fs"));
const config_1 = __importDefault(require("./source/setting/config"));
const connectionpg_1 = __importDefault(require("./source/database/connectionpg"));
const log4js_1 = require("log4js");
class Server {
    constructor() {
        this.app = (0, express_1.default)();
        this.config();
        this.sources();
        this.log();
    }
    config() {
        //Settings
        this.app.set('port', config_1.default.port);
        //Middlewares
        this.app.use((0, morgan_1.default)('dev'));
        this.app.use((0, cors_1.default)());
        this.app.use((0, compression_1.default)());
        this.app.use(express_1.default.json());
        this.app.use(express_1.default.urlencoded({ extended: true }));
        //Rutas
        this.app.use(index_routes_1.default);
    }
    sources() {
        return __awaiter(this, void 0, void 0, function* () {
            //Databases
            yield connectionpg_1.default.conexion();
        });
    }
    log() {
        (0, log4js_1.configure)({
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
        });
    }
    start() {
        try {
            https_1.default.createServer({
                cert: fs_1.default.readFileSync(config_1.default.certCRT, 'utf8'),
                key: fs_1.default.readFileSync(config_1.default.certKEY, 'utf8')
            }, this.app).listen(this.app.get('port'), () => {
                console.log(`Servidor en el puerto ${this.app.get('port')}`);
            });
        }
        catch (error) {
            console.log(error);
        }
    }
}
const server = new Server();
server.start();
