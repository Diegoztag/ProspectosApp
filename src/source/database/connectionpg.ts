import { Sequelize } from "sequelize"
import config from "../setting/config"

class SequelizePg {
  public conn: Sequelize;

  constructor() {
    this.conn = new Sequelize(config.dbPg, config.userPg, config.passwordPg, {
      host: config.hostPg,
      dialect: "postgres",
    });
  }

  public async conexion(){
    await this.conn.authenticate().then(
      __dbpg =>console.log('La conexion a Postgres se ha establecido satisfactoriamente')
    );
  }
}

export default new SequelizePg();