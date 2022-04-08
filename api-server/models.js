const Bookshelf = require('./bookshelf');

// This file is where all the data models (e.g. the database) can be defined
// The top part has some functions for generating tables. Each function tables a "table" object, and then you can
// Add different types of columns to it
//
// The bottom part has the bookshelf models, which should match the table and will be used to query it.
// Whenever you run regenerateTables.js, it will create the tables from the functions defined here

// About Models: You register a model by calling Bookshelf.Bookshelf.model with the name of the model to register, passing in parameters
// When you call Bookshelf.Bookshelf.model without passing in params, it will instead retrieve the models (which is what we do in different files)

function createCourse(table) {
    table.increments('id');
    table.string('fullname');
    table.string('coursecode');
    table.string('department');
}

Bookshelf.BookShelf.model('Course', {
    tableName: 'course'
});

function createUser(table) {
    table.increments('id');
    table.string('name');
    table.string('email');
    table.string('password');
}

Bookshelf.BookShelf.model('User', {
    tableName: 'user'
});

function createScheduledTimeslot(table) {
    table.increments('id');
    table.text('userID');
    table.text('courseID');
    table.string('timeslot');
}

Bookshelf.BookShelf.model('ScheduledTimeslot', {
    tableName: 'scheduledtimeslot'
});

//*STUDY TOPICS TABLE
function createStudyTopic(table) {
    table.increments('id');
    table.text('topicID');
}

Bookshelf.BookShelf.model('StudyTopic', {
    tableName: 'studytopic'
});

//*GROUPS TABLE
function createGroup(table) {
    table.increments('id');
    table.text('groupID');
    table.text('courseID');
    table.text('timeslot');
    table.string('name');
}

Bookshelf.BookShelf.model('Group', {
    tableName: 'group'
});

function createMemberGroup(table) {
    table.increments('id');
    table.integer('userID');
    table.integer('groupID');
}

Bookshelf.BookShelf.model('MemberGroup', {
    tableName: 'membergroup'
});

exports.createUser = createUser;
exports.createCourse = createCourse;
exports.createScheduledTimeslot = createScheduledTimeslot;
exports.createGroup = createGroup;
exports.createMemberGroup = createMemberGroup;

