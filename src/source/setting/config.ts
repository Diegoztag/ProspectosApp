import {config} from "dotenv"

config()

export default {
    port: process.env.PORT || 4000,
    hostPg: process.env.HOST_PG || '',
    userPg: process.env.USER_PG || '',
    passwordPg: process.env.PASSWORD_PG || '',
    dbPg: process.env.DB_PG || '',
    certCRT: process.env.CERTIFICADO_CRT || '',
    certKEY: process.env.CERTIFICADO_KEY || '',
}