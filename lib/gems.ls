require! {
  Q: q
  child_process
}

function rbCommand (exec, map)
  "ruby -r active_support/all -r gems -e \"puts #{ exec }.#{ map }.to_json\""

module.exports = do
  search: (keyword) ->
    Q.nfcall child_process.exec, rbCommand do
      "Gems.search('#{ keyword }')"
      "map { |h| h.slice('name', 'authors', 'info') }"
    .spread JSON.parse

  info: (name) ->
    Q.nfcall child_process.exec, rbCommand do
      "Gems.info('#{ name }')"
      "slice('name', 'authors', 'info')"
    .spread JSON.parse