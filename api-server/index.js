const Bookshelf = require('./bookshelf');
const express = require('express');
const scheduling = require('./scheduling');
var bodyParser = require('body-parser');
var tableValues = require('../api-server/userstable');

const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.json());

const port = process.env.PORT;

console.log(tableValues);


app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.post('/user/:id/scheduled-timeslots', async (req, res) => {
    let scheduleData = req.body;
    if (!scheduleData.courseID || !scheduleData.timeslot) {
        return res.json({ 'message': `Could not schedule timeslot because of missing parameters` });
    }

    res.json(await scheduling.schedule_user(req.params.id, scheduleData.courseID, scheduleData.timeslot));
});

app.get('/user/:id/scheduled-timeslots', async (req, res) => {
    if (await Bookshelf.BookShelf.model('ScheduledTimeslot').where({ 'userID': req.params.id }).count() > 0) {
        let timeslots = await Bookshelf.BookShelf.model('ScheduledTimeslot').where({ 'userID': req.params.id }).fetchAll();
        res.json({ "message": "OK", "timeslots": timeslots });
    } else {
        res.json({ "message": "OK", "timeslots": {} });
    }
});

app.get('/users', async (req, res) => {
    let userTable = await Bookshelf.BookShelf.model('User').fetchAll();
    res.json(userTable);
});

app.post('/users', async (req, res) => {
     Bookshelf.BookShelf.model('User').forge({
        name: req.body.name,
        email: req.body.email,
        password: req.body.password
    }).save();
    let userTable = await Bookshelf.BookShelf.model('User').fetchAll();
    res.json(userTable);
});

app.listen(port, () => {
    console.log(`API server running on port ${port}`);
});
