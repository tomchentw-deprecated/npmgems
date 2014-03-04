require! {
  Sequelize: sequelize
  '../../config/sequelize'
}

module.exports = sequelize.define 'User' do
  username: Sequelize.STRING
  displayName: Sequelize.STRING
  email: Sequelize.STRING
  github: type: Sequelize.HSTORE
