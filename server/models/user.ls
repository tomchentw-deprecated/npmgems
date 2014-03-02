require! {
  Sequelize: sequelize
  '../../config/sequelize'
}

const User = sequelize.define 'User' do
  username: Sequelize.STRING
  password: Sequelize.STRING

# sequelize.sync force: true

module.exports = User
