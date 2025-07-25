// import 'dotenv/config'


// const config =   {
//   "development": {
//     "username": "postgres",
//     "password": "password1",
//     "database": "savesente_dev",
//     "host": "127.0.0.1",
//     "dialect": "postgres"
//   },r
//   "test": {
//     "username": "root",
//     "password": null,
//     "database": "database_test",
//     "host": "127.0.0.1",
//     "dialect": "mysql"
//   },
//   "production": {
//     "username": "root",
//     "password": null,
//     "database": "database_production",
//     "host": "127.0.0.1",
//     "dialect": "mysql"
//   }
// }
// export default config

import 'dotenv/config'

const config = {
  development: {
    username: "postgres",
    password: "password1",
    database: "savesente_dev",
    host: "127.0.0.1",
    dialect: "postgres"
  },
  test: {
    username: "root",
    password: null,
    database: "database_test",
    host: "127.0.0.1",
    dialect: "mysql"
  },
  production: {
    username: "root",
    password: null,
    database: "database_production",
    host: "127.0.0.1",
    dialect: "mysql"
  }
}

export default config