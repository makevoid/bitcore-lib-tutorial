# TODO: implement DSL, run via opal

# current stubs (WIP):

require_relative 'private_key'
require_relative 'transaction'

fileRead = -> (file) {
  File.read file
}

def bitcore
  obj = {}
  obj[:private_key] = -> {
    "K..."
  }
  obj[:transaction] = -> {
    "x..."
  }
end

getUTXOs = -> (address) {
  utxos = []
  # get_utxos ...
  utxos
}

pushTx = -> (tx_hash) {
  # tx_hash ...
  {
    success: true,
    tx_hash: "abcd1234",
  }
}

class Hash
  alias :f :fetch
end

EXPORTS = {
  path: File.expand_path("../../", __FILE__),
  getUTXOs: getUTXOs,
  pushTx: pushTx,
  fileRead: fileRead,
  bitcore: bitcore,
  PrivateKey: PrivateKey,
  Transaction: Transaction,
}
