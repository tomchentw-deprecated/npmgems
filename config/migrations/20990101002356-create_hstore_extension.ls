function up (migration, DataTypes, done)
  migration
  .query 'CREATE EXTENSION IF NOT EXISTS hstore;'
  .complete done

function down (migration, DataTypes, done)
  done!

module.exports = {up, down}