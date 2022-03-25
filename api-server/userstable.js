const Bookshelf = require('../api-server/bookshelf');
const users = require('../api-server/models');

var userData;

Bookshelf.BookShelf.model('User').fetchAll().then(function (resData) {
   userData = resData.serialize();
});

module.exports = userData;