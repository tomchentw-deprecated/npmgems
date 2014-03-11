require! {
  '../controllers/comments'
}

module.exports = !(app) ->

  app.post '/api/comments' comments.create

  app.post '/api/comments/:id' comments.update
