require('dotenv').config();

const knex = require('knex') ({
    debug: true,
    client: 'pg',
    version: '12',
    connection: {
        host: '127.0.0.1',
        port: 5432,
        user: process.env.DATABASE_USER,
        database: process.env.DATABASE,
        password: process.env.DATABASE_PASSWORD 
    }
});

const bookshelf = require('bookshelf')(knex);
module.exports.BookShelf = bookshelf; 
module.exports.knex = knex;