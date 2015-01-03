This is the location of the backups of the environments.

Database backups:
-----------------

/backup/db/<databasename>
    <databasename>.latest.dmp - the latest backup
    <databasename>.schema-latest.dmp - the latest backup - tables only
    <databasename>.seed-latest.dmp - the latest backup - seed data only
    <databasename>.yyyy-mMM.dmp - the latest backup from the specified month
    <databasename>.(Mon-Sun).dmp - the latest backup taken on the weekday in question
    <databasename>.hr(01-24).dmp - hourly backups
