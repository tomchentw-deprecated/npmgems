require! {
  Comment: '../models/comment'
  User: '../models/user'
}

exports.create = !(req, res) ->
  const {mappingId, action, content} = req.body
  const comment = Comment.create do
    MappingId: mappingId
    AuthorId: req.user.id
    action: action
    content: content
  .then (comment) ->
    Comment.findWithAuthor comment.id

  res.json do
    result: comment

exports.update = !(req, res) ->
  const {body} = req
  const comment = do
    Comment
    .findWithAuthor body.id
    .then (comment) ->
      comment.updateAttributes body, <[ action content ]>

  res.json do
    result: comment
