const {Sequelize } = require("sequelize");
const dbConfig = require('./db.config');

const sequelize = new Sequelize(dbConfig.database, dbConfig.user, 
                                 dbConfig.password, 
                                 { host: dbConfig.host,
                                   dialect: 'mysql'
                                 });
module.exports = sequelize;