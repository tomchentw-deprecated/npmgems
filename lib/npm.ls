require! {
  Q
}

const promise = Q.nfcall require('npm').load, {}

function object2Array (object)
  [value{name, author, description} for name, value of object]

module.exports = do
  search: (keyword) ->
    (npm) <- promise.then
    Q.nfcall npm.commands.search, [keyword], true, 2000
    .then object2Array