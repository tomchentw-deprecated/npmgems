require! {
  Sequelize: sequelize
  '../config/sequelize'
}

const User = module.exports = sequelize.define 'User' do
  username: Sequelize.STRING
  displayName: Sequelize.STRING
  email: Sequelize.STRING
  github: type: Sequelize.HSTORE

User.permittedAttributes = <[ id username displayName ]>
