const BookShelf = require('../bookshelf');
const Models = require('../models');

// Drop, and then create all the tables
(async () => {
    await BookShelf.knex.schema.dropTableIfExists('course').createTable('course', Models.createCourse).catch(err => console.error(err));
    await BookShelf.knex.schema.dropTableIfExists('user').createTable('user', Models.createUser).catch(err => console.error(err));
    await BookShelf.knex.schema.dropTableIfExists('scheduledtimeslot').createTable('scheduledtimeslot', Models.createScheduledTimeslot).catch(err => console.error(err));
    process.exit();
})();