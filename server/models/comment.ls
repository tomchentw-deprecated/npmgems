require! {
  Sequelize: sequelize
  '../../config/sequelize'
  Mapping: './mapping'
  User: './user'
}

const Comment = module.exports = sequelize.define 'Comment' do
  MappingId: do
    type: Sequelize.INTEGER
    references: Mapping
    referencesKey: 'id'
  AuthorId: do
    type: Sequelize.INTEGER
    references: User
    referencesKey: 'id'
  action: Sequelize.ENUM(...<[ up down ]>)
  content: Sequelize.TEXT

Comment.belongsTo User, as: 'author', foreignKey: 'AuthorId'
Comment.belongsTo Mapping

User.hasMany Comment, foreignKey: 'AuthorId'
Mapping.hasMany Comment
