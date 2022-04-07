const express = require('express');
const Bookshelf = require('./bookshelf');
const scheduling = require('./scheduling');
const { createCourse } = require('./models');

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
        res.json({ "message": "OK", "timeslots": [] });
    }
});

// fetch all of the users in the server
app.get('/users', async (req, res) => {
    let userTable = await Bookshelf.BookShelf.model('User').fetchAll();
    res.json(userTable);
});

//fetch all courses offered
app.get('/course', async (req, res) => {
    let courseTable = await Bookshelf.BookShelf.model('Course').fetchAll();
    res.json(courseTable)
})

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
    if (!userID) {
        ws.send(JSON.stringify({ 'message': 'User ID is required for connection, but not supplied' })); return;
    }

    let now = new Date();
    let today = now.getDay() - 1, time = now.getHours();
    let timeslots = await Bookshelf.BookShelf.model('ScheduledTimeslot').where({ 'userID': req.params.id }).fetchAll();
    timeslots = timeslots.sort((a, b) => {
        let t1_day = parseInt(a.slice(0, 2));
        let t1_time = parseInt(a.slice(2));
        let t2_day = parseInt(b.slice(0, 2));
        let t2_time = parseInt(b.slice(2));

        if (t1_day < today) {
            t1_day += 7;
        }

        if (t2_day < today) {
            t2_day += 7;
        }

        if (Math.abs(t1_day - today) < Math.abs(t2_day - today)) {
            return -1;
        } else if (Math.abs(t1_day - today) > Math.abs(t2 - today)) {
            return 1;
        }

        return 0;
    });

    ws.send(JSON.stringify(timeslots[0]));
});

app.get('/group', async (req, res) => {
    let userTable = await Bookshelf.BookShelf.model('Group').fetchAll();
    res.json(userTable);
});

app.get('/membergroup', async (req, res) => {
    let userTable = await Bookshelf.BookShelf.model('MemberGroup').fetchAll();
    res.json(userTable);
});


app.get('/user/:id/groups', async (req, res) => {

    let userData = req.body;

    console.log("USER ID", req.params.id);

    let group = await Bookshelf.BookShelf.model('MemberGroup').where({ "userID": req.params.id }).fetchAll();

    //Returns all groups the user is in from MemberGroup table
    let newgroup = group.serialize();

    console.log("New GROUP: ", newgroup[0].groupID);
    console.log("len of GROUP: ", newgroup.length);

    if (group.length == 0) {
        res.json({ "message": "404" });
    }

    else {
        let data = []
        let memberRecords = []
        let nameRecords = []

        //Returns all members the groupsList from MemberGroup table
        for (let j = 0; j < group.length; j++) {
            let temp = await Bookshelf.BookShelf.model('MemberGroup').where({ "groupID": newgroup[j].groupID }).fetchAll();
            data.push(temp.serialize());
        }


        //Returns all the members in these groups from MemberGroup table

        for (j = 0; j < data.length; j++) {
            for (x = 0; x < data[j].length; x++) {

                let tempTwo = await Bookshelf.BookShelf.model('User').where({ "id": data[j][x].userID }).fetchAll();
                memberRecords.push(tempTwo.serialize());
            }
        }

        console.log("Member Records: ", memberRecords);

        for (let j = 0; j < memberRecords.length; j++) {
            nameRecords.push(memberRecords[j][0].name);
        }

        res.json(nameRecords);
    }

});

app.post('/group/join', async (req, res) => {

    // being passed as userID, timeslot

    let userData = req.body;

    let temp = await Bookshelf.BookShelf.model('Group').where({ "timeslot": userData.timeslot }).fetchAll();

    let userAdded = false;

    let groupTables = temp.serialize();

    console.log("groupTables", groupTables);

    if (groupTables.length != 0) {
        for (let i = 0; groupTables && i < groupTables.length; i++) {
            console.log(groupTables[i]);
            if (await Bookshelf.BookShelf.model('MemberGroup').where({ "groupID": groupTables[i].id }).count() < 5) {

                Bookshelf.BookShelf.model('MemberGroup').forge({
                    userID: userData.userID,
                    groupID: groupTables[i].id,
                }).save();

                userAdded = true;
                break;

            }
        }
    }

    if (userAdded == false) {

        let uniqueName = Date.now();
        let groupid;

        Bookshelf.BookShelf.model('Group').forge({
            name: uniqueName,
            timeslot: userData.timeslot,
        }).save().then(function (u) {
            groupid = u.get('id');
            Bookshelf.BookShelf.model('MemberGroup').forge({
                userID: userData.userID,
                groupID: groupid
            }).save().then(function (u) {
                console.log('User saved:', groupid);
            });

        });
    }

    res.json({ "message": "OK" });
});

app.listen(port, () => {
    console.log(`API server running on port ${port}`);
});




/// TO DO: 