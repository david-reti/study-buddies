const express = require('express');
const Bookshelf = require('./bookshelf');
const scheduling = require('./scheduling');

const app = express();
app.use(express.json());
const ws = require('express-ws')(app);

const port = process.env.PORT;

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
        res.json({ "message": "OK", "timeslots": []});
    }
});

// fetch all of the users in the server
app.get('/users', async (req, res) => {
    let userTable = await Bookshelf.BookShelf.model('User').fetchAll();
    res.json(userTable);
});

// create a new user based on the information passed when the user is registrating
app.post('/users', async (req, res) => {
    Bookshelf.BookShelf.model('User').forge({
        name: req.body.name,
        email: req.body.email,
        password: req.body.password
    }).save();
    let userTable = await Bookshelf.BookShelf.model('User').fetchAll();
    res.json(userTable);
});

// Socket for study sessions - will send a message when it's time to start the session, and when the session is over
app.ws('/socket/study_sessions', async (ws, req) => {
    const userID = req.query.userID;
    if(!userID) {
        ws.send(JSON.stringify({'message' : 'User ID is required for connection, but not supplied'})); return;
    }

    let now = new Date();
    let today = now.getDay() - 1, time = now.getHours();
    let timeslots = await Bookshelf.BookShelf.model('ScheduledTimeslot').where({ 'userID': req.params.id }).fetchAll();
    timeslots = timeslots.sort((a, b) => {
        let t1_day = parseInt(a.slice(0, 2));
        let t1_time = parseInt(a.slice(2));
        let t2_day = parseInt(b.slice(0, 2));
        let t2_time = parseInt(b.slice(2));

        if(t1_day < today) {
            t1_day += 7;
        }

        if(t2_day < today) {
            t2_day += 7;
        }

        if(Math.abs(t1_day - today) < Math.abs(t2_day - today)) {
            return -1;
        } else if(Math.abs(t1_day - today) > Math.abs(t2 - today)) {
            return 1;
        }

        return 0;
    });

    ws.send(JSON.stringify(timeslots[0]));
});

app.listen(port, () => {
    console.log(`API server running on port ${port}`);
});
