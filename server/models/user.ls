require! {
  Sequelize: sequelize
  '../config/sequelize'
}

const User = module.exports = sequelize.define 'User' do
  username:     Sequelize.STRING
  displayName:  Sequelize.STRING
  gravatarId:   Sequelize.STRING
  email:        Sequelize.STRING
  github: do
    type:       Sequelize.HSTORE

User.permittedAttributes = <[ id username displayName gravatarId ]>
