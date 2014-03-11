require! {
  Comment: '../models/comment'
}

exports.create = !(req, res) ->
  const {mappingId, action, content} = req.body

  res.json result: Comment.create do
    MappingId: mappingId
    AuthorId: req.user.id
    action: action
    content: content

exports.update = !(req, res) ->
  const {body} = req

  res.json do
    result: Comment.find body.id .then (comment) ->
      comment.updateAttributes body, <[ action content ]>
