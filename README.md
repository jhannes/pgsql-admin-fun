This project demonstrates PostgreSQL backup and availability.

It sets up a number of virtual machines with Vagrant and implements a
regime with hot standby and backups.

Demonstration:
--------------

1. Start up the standby server so the primary has a place to send files
   * cd db-2standby
   * vagrant up
2. The standby server is now running on 192.168.100.102, but
   the Postgres service is not running
3. Start up the primary server
   * cd db-1primary
   * vagrant up
4. The primary server is now accessible at 192.168.100.101
   with a backup from /backup/db
5. The standby server is accessible at 192.168.100.102 and
   updates and inserts in the primary will be showed in
   the seconday
   * For some reason, the script for primary doesn't bring up standby correctly!
6. The standby server performs backup every hour to /backup.
7. Run the backup manually at the standby server with
   /shared/bin/backup-db.sh testdb
8. Start up the clone and the skeleton
   * cd db-3clone
   * vagrant up
   * cd db-4skeleton
   * vagrant up
9. These servers (running at 192.168.100.103 and 192.168.100.104)
   will be initialized from backups. The clone will contain the
   full database, while the skeleton will only contain schemas
   and seed data.

TODO:

* Bring up primary first and use ssh on standby to attach
* Better key management?
* host file?
* Include a test of fail over to standby server with new standby
* Include a demonstration of Flyway
* use dump to create secondary dumps

Flyway:
-------

1. test server db-5development
2. Initalized from pg_dump --format=plain

