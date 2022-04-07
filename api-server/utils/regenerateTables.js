const fs = require('fs');
const BookShelf = require('../bookshelf');
const Models = require('../models');

async function loadSampleData(modelName) {
    let data = JSON.parse(fs.readFileSync(`./sampleData/${modelName.toLowerCase()}.json`));
    for (let i = 0; i < data.length; i++) await BookShelf.BookShelf.model(modelName).forge(data[i]).save();
}

// Drop, and then create all the tables
(async () => {
    await BookShelf.knex.schema.dropTableIfExists('course').createTable('course', Models.createCourse).catch(err => console.error(err));
    await BookShelf.knex.schema.dropTableIfExists('user').createTable('user', Models.createUser).catch(err => console.error(err));
    await BookShelf.knex.schema.dropTableIfExists('scheduledtimeslot').createTable('scheduledtimeslot', Models.createScheduledTimeslot).catch(err => console.error(err));
    await BookShelf.knex.schema.dropTableIfExists('group').createTable('group', Models.createGroup).catch(err => console.error(err));
    await BookShelf.knex.schema.dropTableIfExists('membergroup').createTable('membergroup', Models.createMemberGroup).catch(err => console.error(err));
    // Load sample data
    await loadSampleData('User');
    await loadSampleData('Course');
    await loadSampleData('ScheduledTimeslot');
    process.exit();
})();