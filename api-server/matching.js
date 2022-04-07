//*MATCHING:
// creates a unique group  in the group table and assigns
// every user in the user table to a group depending on the 
// timeslot they have chosen

const Bookshelf = require('./bookshelf');
const Models = require('./models');

//*INITIALIZE GROUPS TABLE BASED ON COURSE AND TIMESLOTS
module.exports.setup_group = async (courseID, timeslot) => {
    let groupID = "";

    // Check if group already exists
    let conflicts = await Bookshelf.BookShelf.model('Group').where({
        'timeslot' : timeslot,
        'courseID' : courseID
    }).count();

    if(conflicts > 0) { return {'message' : 'Could not create group because it already exists'}; }
    
    groupID = groupID + courseID + " " + timeslot;

    // Create the group and return
    await Bookshelf.BookShelf.model('Group').forge({
        groupID: groupID,
        courseID: courseID,
        timeslot: timeslot
    }).save();

    return {"message" : "OK", "group": await Bookshelf.BookShelf.model('Group').where({"groupID": groupID, "courseID": courseID, "timeslot": timeslot}).fetch()};
}

//*MATCH USER INTO GROUP BASED ON THEIR COURSE AND TIMESLOT
module.exports.match_user = async (userID, courseID, timeslot) => {

    // Check for any conflicting timeslots
    let groupId2 = await Bookshelf.BookShelf.model('Group').where({
        'timeslot' : timeslot,
        'courseID' : courseID
    }).get("groupID").toString();

    console.log(groupId2);
    if(groupId2.length <= 0) { return {'message' : 'Could not match user into a group.'}; }

    await Bookshelf.BookShelf.model('GroupUser').forge({
        userID: userID,
        groupID: groupId2
    }).save();

    return {"message" : "OK", "groupuser": await Bookshelf.BookShelf.model('GroupUser').where({"userID": userID, "groupID": groupID2[0]}).fetch()};
}
