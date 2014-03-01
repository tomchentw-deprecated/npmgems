require! {
  Q
}

const promise = Q.nfcall require('npm').load, {}

function object2Array (object)
  Object.keys object .map -> object[it]


module.exports = do
  search: (keyword) ->
    (npm) <- promise.then
    Q.nfcall npm.commands.search, [keyword] true
    .then object2Array