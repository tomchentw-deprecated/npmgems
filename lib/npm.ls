require! {
  Q: q
}

const promise = Q.nfcall require('npm').load, {}

function sliceObject (object)
  object{name, author, description}

module.exports = do
  search: (keyword) ->
    function normalize (object)
      [sliceObject value for name, value of object]

    (npm) <- promise.then
    Q.nfcall npm.commands.search, [keyword], true, 2000
    .then normalize

  info: (name) ->
    function normalize (object)
      for version, value of object
        return sliceObject value

    (npm) <- promise.then
    Q.nfcall npm.commands.info, [name], true
    .then normalize



