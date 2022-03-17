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
DATABASE=<database-name>
DATABASE_USER=<database-user-name>
DATABASE_PASSWORD=<database-password>
```

### Inspecting Tables

It is recommended to use our library, [Bookshelf](https://bookshelfjs.org/index.html) for accessing the database. To do manual table manipulation, you will need to use a command-line tool called psql, which opens and a shell to interact with the databas, and which needs to be run as follows: `psql -t <your_table_name> -u <user_name_if_not_same_as_linux_username>`. You can then run various commands with it, most notably `\d` to describe tables, and `\q` to quit.