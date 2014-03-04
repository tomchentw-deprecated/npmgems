require! {
  Q: q
  Sequelize: sequelize
}

const config = do
  dialect: 'postgres'
  port: 5432

module.exports = new Sequelize 'npmgems', void, void, config
