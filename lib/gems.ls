require! {
  Q: q
  request
}

function rubygemsUrl (name)
  "https://rubygems.org/api/v1/gems/#name.json"

module.exports = do
  search: (keyword) ->
    Q.reject 'not implemented'

  info: (name) ->
    Q.nfcall request, rubygemsUrl(name)
    .spread (response, body) ->
      JSON.parse body


