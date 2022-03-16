const express = require('express');
const knex = require('knex') ({
    client: 'pg',
    version: '12',
    connection: {
        host: '127.0.0.1',
        port: 5432,
        user: process.env['DATABASE_USER'],
        database: process.env['DATABASE'],
        password: process.env['DATABASE_PASSWORD'] 
    }
});

const bookshelf = require('bookshelf')(knex);

const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.listen(port, () => {
    console.log(`API server running on port ${port}`);
});