require! {
  fs
  path
  Q: q
}
require! {
  '../config/express'
  '../config/sequelize'
}

const app = express!

function traverse (base)
  <- Q.nfcall fs.readdir, base .then

  Q.all it.map (route) ->
    const newPath = "#base#{ path.sep }#route"
    (stat) <- Q.nfcall fs.stat, newPath .then
    if stat.isDirectory! and 'middlewares' isnt route
      return traverse newPath
    if stat.isFile!
      require(newPath)(app)
    stat

Q.all [
  sequelize.authenticate!
  traverse './routes'
]
.then ->
  

  app.use app.router

  # app.use express.favicon!
  app.use express.static path.join ...<[ .. public ]>
  app.use express.static path.join ...<[ .. tmp public ]>

  console.log 'express started at 5000'
  app.listen 5000

.fail -> console.log it