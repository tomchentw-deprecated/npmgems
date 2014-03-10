require! {
  '../controllers/comments'
}

module.exports = !(app) ->

  app.post '/api/comments' comments.create
