require! {
  Q
  child_process
}

module.exports = do
  search: (keyword) ->
    Q.nfcall child_process.exec, "ruby -r json -r gems -e \"puts Gems.search('#{ keyword }').to_json\""
    .spread JSON.parse