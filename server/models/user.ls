require! {
  Sequelize: sequelize
  '../../config/sequelize'
}

module.exports = sequelize.define 'User' do
  username: Sequelize.STRING
  password: Sequelize.STRING
