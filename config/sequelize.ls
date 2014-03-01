require! {
  Q: q
  Sequelize: sequelize
}

module.exports = new Sequelize 'npmgems', void, void, do
  dialect: 'postgres'
  port: 5432
