require! {
  Sequelize: sequelize
  '../config/sequelize'
}

module.exports = sequelize.define 'Mapping' do
  npm: do
    type: Sequelize.STRING
    unique: 'npm_and_gems'
  npmDesc: Sequelize.TEXT
  gems: do
    type: Sequelize.STRING
    unique: 'npm_and_gems'
  gemsDesc: Sequelize.TEXT
