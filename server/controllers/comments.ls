require! {
  Comment: '../models/comment'
}

exports.create = !(req, res) ->
  const {mappingId, content} = req.body

  res.json result: Comment.create do
    MappingId: mappingId
    AuthorId: req.user.id
    content: content