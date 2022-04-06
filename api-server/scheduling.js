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
exports.DAY_TIMES = DAY_TIMES;