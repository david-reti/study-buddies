const Bookshelf = require('./bookshelf');
const Models = require('./models');

const DAY_TIMES = ['Morning (10:30 - 11:30)', 'Afternoon (2:30 - 3:30)', 'Evening (5:30 - 6:30)', 'Night (8:30 - 9:30)']; // The times on each day when a meeting could take place
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