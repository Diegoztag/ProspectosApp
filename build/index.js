"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const morgan_1 = __importDefault(require("morgan"));
const compression_1 = __importDefault(require("compression"));
const cors_1 = __importDefault(require("cors"));
class Server {
    constructor() {
        this.app = (0, express_1.default)();
        this.config();
    }
    config() {
        //Settings
        this.app.set('port', 2000);
        //Middlewares
        this.app.use((0, morgan_1.default)('dev'));
        this.app.use((0, cors_1.default)());
        // this.app.use(helmet()); //Ojo anda dando problemas switchea de http a https en localhost
        this.app.use((0, compression_1.default)());
        this.app.use(express_1.default.json());
        this.app.use(express_1.default.urlencoded({ extended: true }));
    }
    start() {
        try {
            this.app.listen(this.app.get('port'), () => {
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
