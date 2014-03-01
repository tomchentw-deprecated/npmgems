require! {
  Sequelize: sequelize
  '../../config/sequelize'
}

const Mapping = sequelize.define 'Mapping' do
  npm: Sequelize.STRING
  gems: Sequelize.STRING

sequelize.sync force: true

module.exports = Mapping
