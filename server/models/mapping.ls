require! {
  Sequelize: sequelize
  '../../config/sequelize'
}

module.exports = sequelize.define 'Mapping' do
  npm: Sequelize.STRING
  gems: Sequelize.STRING
