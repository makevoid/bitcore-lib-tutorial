require_relative 'lib/monkeypatches'
path        = EXPORTS.f(:path)
fileRead    = EXPORTS.f(:fileRead)
bitcore     = EXPORTS.f(:bitcore)
PrivateKey  = EXPORTS.f(:PrivateKey)
Transaction = EXPORTS.f(:Transaction)
getUTXOs    = EXPORTS.f(:getUTXOs)
pushTx      = EXPORTS.f(:pushTx)

# # alternative syntax without explicit import:
# bitcore = require('bitcore-lib')
# PrivateKey  = bitcore.private_key.()
# Transaction = bitcore.transaction.()

pvt_key_string = fileRead.("#{path}/../../private-key.txt").strip()
pvt_key = PrivateKey.new pvt_key_string

address = pvt_key.to_address()

puts "private key: #{pvt_key}"
puts "address: #{address}"

utxos = getUTXOs.(address)

utxos = [ utxos[0] ]

puts "utxos: #{utxos}"

amount = 10_000 # sats (0.1 mbtc)

tx = Transaction.new
tx.from(utxos)
  .to(address, amount)
  .change(address)
  .fee(1000)
  .sign(pvt_key)

tx_hex = tx.serialize()
puts "tx: #{tx_hex}"

tx_status = pushTx.(tx_hex)
puts "tx_status: #{tx_status.inspect}"
