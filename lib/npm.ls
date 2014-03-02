require! {
  Q
}

const promise = Q.nfcall require('npm').load, {}

function sliceObject (object)
  object{name, author, description}

function object2Array (object)
  [sliceObject value for name, value of object]

module.exports = do
  search: (keyword) ->
    (npm) <- promise.then
    Q.nfcall npm.commands.search, [keyword], true, 2000
    .then object2Array

  info: (name) ->
    (npm) <- promise.then
    Q.nfcall npm.commands.info, name
    .then sliceObject



