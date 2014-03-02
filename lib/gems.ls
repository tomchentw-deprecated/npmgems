require! {
  Q
  child_process
}

const COMMAND_PRE = "ruby -r active_support/all -r gems -e \"puts Gems.search('"
const COMMAND_POST = "').map{|h|h.slice('name', 'authors', 'info')}.to_json\""

module.exports = do
  search: (keyword) ->
    Q.nfcall child_process.exec, "#COMMAND_PRE#keyword#COMMAND_POST"
    .spread JSON.parse
