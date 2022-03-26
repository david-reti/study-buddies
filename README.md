# Study Buddies

This is the repository for our mobile application project. Unlike in a more conventional workflow, we'll keep all the parts of the project (flutter app, API and any additional data) in separate folders within this repository, for greater convenience.

## Development Workflow

Here's how the project will be developed:

1. Group members clone the repository
2. Group members make changes by working on their part in their respective folder
3. Instead of pushing to main, group members will push to their own branched (at least 1 per person)
4. When a group member has completed their part, we'll look over their code in our weekly meeting and merge it
5. When the code is merged, the repository will be automatically pulled on our AWS server and become accessible

Any ongoing tasks can be found in their respective branches; As a team we will discuss merging and updates on our group on MS Teams.

## Connecting to Database

Every team member has their own database for testing. In order to make a database connection, you need to use your credentials, which we don't want to store in our repository for security reasons. Instead, they will be stored in a file called `api-server/.env`. Because this file is not checked in, you will have to create it after you clone to repository to your home folder. The format should be as follows:

```
PORT=<your_assigned_port>
DATABASE=<database-name>
DATABASE_USER=<database-user-name>
DATABASE_PASSWORD=<database-password>
```

### Inspecting Tables

It is recommended to use our library, [Bookshelf](https://bookshelfjs.org/index.html) for accessing the database. To do manual table manipulation, you will need to use a command-line tool called psql, which opens and a shell to interact with the databas, and which needs to be run as follows: `psql -t <your_table_name> -u <user_name_if_not_same_as_linux_username>`. You can then run various commands with it, most notably `\d` to describe tables, and `\q` to quit.

### Regenerating Tables

In development, it's very useful to wipe all the tables and generate them again - either becuase you are running it for the first time and you want to generate the tables, or you modified the schema and want to see the changes, or because you want to get rid of all the data in the database. This is simple: just use the script for this purpose: `yarn run regen` and it will recreate all the tables in your database.

### Creating Tables

All the tables are defined in [models.js](./api-server/models.js) - you should read the comment at the top of the file for more information about its structure. To create a table, you will need to:

1. Define a function to generate the table (see the examples, it will need to include the type of each column). It should also be exported at the bottom of the file: `module.exports.<your_function> = your_function`.
2. Define a mapping to go from the table to Bookshelf - this is called a model and you can see examples of it in the file. There are two version of this function call: when you call `Bookshelf.model('name', { <options> })` it will register the model with bookshelf. You should always include `tableName` in the options. When you just write `Bookshelf.model('name')`, it will instead retrieve it from bookshelf. We do this because if we exported / imported the objects directly, there would be circular dependency problems - this setting / retreival scheme eliminates them.
3. Add the code to generate / regenerate the table - this should go in [regenerateTables.js](./api-server/utils/regenerateTables.js) - the easiest way it to copy the code which is already there; The options are mostly self-explanatory, but it's important to make sure that the name of the table (the string passed into createTable) is the same as the one you wrote in the Bookshelf model in step 2, and that the second argument to to createTable is the function you wrote in step 2 to generate the table (`Models.<your_function>`)
4. Remember to regenerate tables in order to see you changes