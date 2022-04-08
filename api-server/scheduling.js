const Bookshelf = require('./bookshelf');
const Models = require('./models');

// The times on each day when a meeting could take place
const DAY_TIMES = [
    {
        title: 'Morning (10:30 - 11:30)',
        startHour: 10,
        startMinute: 30,
        endHour: 11,
        endMinute: 30
    },
    {
        title: 'Afternoon (2:30 - 3:30)',
        startHour: 14,
        startMinute: 30,
        endHour: 15,
        endMinute: 30
    },
    {
        title: 'Evening (5:30 - 6:30)',
        startHour: 17,
        startMinute: 30,
        endHour: 18,
        endMinute: 30
    },
    {
        title: 'Night (8:30 - 9:30)',
        startHour: 20,
        startMinute: 30,
        endHour: 21,
        endMinute: 30
    }
]
const TIMESLOTS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'].map(day => { day: DAY_TIMES });

module.exports.schedule_user = async (userID, courseID, timeslot) => {
    // Check for any conflicting timeslots
    let conflicts = await Bookshelf.BookShelf.model('ScheduledTimeslot').where({'timeslot' : timeslot}).count();
    if(conflicts > 0) { return {'message' : 'Could not schedule in this timeslot because there is a timing conflict'}; }

    // Create the scheduling and return the result
    await Bookshelf.BookShelf.model('ScheduledTimeslot').forge({
        userID: userID,
        courseID: courseID,
        timeslot: timeslot
    }).save();

    return {"message" : "OK", "timeslot": await Bookshelf.BookShelf.model('ScheduledTimeslot').where({"userID": userID, "courseID": courseID, "timeslot": timeslot}).fetch()};
}

module.exports.nextTimeslot = timeslots => {
    // Sort the timeslots to find the next one
    let timeslotsToSort = Array.from(timeslots);
    timeslotsToSort.sort((a, b) => {
        // let t1_day = parseInt(a.slice(0, 2));
        // let t1_time = parseInt(a.slice(2));
        // let t2_day = parseInt(b.slice(0, 2));
        // let t2_time = parseInt(b.slice(2));

        // if(t1_day < today) {
        //     t1_day += 7;
        // }

        // if(t2_day < today) {
        //     t2_day += 7;
        // }

        // if(Math.abs(t1_day - today) < Math.abs(t2_day - today)) {
        //     return -1;
        // } else if(Math.abs(t1_day - today) > Math.abs(t2 - today)) {
        //     return 1;
        // }

        return 0;
    });
    return timeslotsToSort[0];
}
exports.DAY_TIMES = DAY_TIMES;