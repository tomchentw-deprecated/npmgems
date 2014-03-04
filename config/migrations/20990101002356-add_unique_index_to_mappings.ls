function up (migration, DataTypes, done)
  migration.addIndex do
    'Mappings'
    <[ gems npm ]>
    indicesType: 'UNIQUE'
  .complete done

function down (migration, DataTypes, done)
  migration.removeIndex do
    'Mappings'
    <[ gems npm ]>
  .complete done

module.exports = {up, down}