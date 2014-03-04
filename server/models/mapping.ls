require! {
  Sequelize: sequelize
  '../../config/sequelize'
}

module.exports = sequelize.define 'Mapping' do
  npm: Sequelize.STRING
  npmDesc: Sequelize.TEXT
  gems: Sequelize.STRING
  gemsDesc: Sequelize.TEXT
