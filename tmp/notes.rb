# rewrite using a dsl dialect

# TODO: implement DSL, run via opal

# current stubs (WIP):

def require(module)
  # call node's require
end

def File.read
  "...."
end

def bitcore
  obj = Object.new
  obj.private_key = -> {
    "K..."
  }
  obj.transaction = -> {
    "x..."
  }
end

class PrivateKey
  def initialize

  end

  def to_address
    "1...."
  end
end


class Transaction

  def initialize

  end

  def from(utxos)
    self
  end

  def to(address, amount)
    self
  end

  def change(amount)
    self
  end

  def fee(amount)
    self
  end

  def sign(private_key)
    self
  end

end

getUTXOs = -> () {
  Object.new
}

pushTX = -> () {
  {
    success: true,
    tx_hash: "abcd1234",
  }
}

# ----

# final DSL:

bitcore = require('bitcore-lib')
PrivateKey  = bitcore.private_key.()
Transaction = bitcore.transaction.()

pvt_key_string = File.read.strip()
pvt_key = PrivateKey.new pvt_key_string

address = pvt_key.to_address.()

puts "private key: #{pvt_key}"
puts "address: #{address}"

utxos = getUTXOs.(address)

utxos = [ utxos[0] ]

puts "utxos: #{utxos}"

amount = 10_000 // sats (0.1 mbtc)

tx = Transacttion.new
      .from(utxos)
      .to(address, amount)
      .change(address)
      .fee(1000)
      .sign(pvtKey)

tx_hex = tx.serialize()

puts "tx: #{tx_hex}"

tx_status = pushTx.(txHex)





    const { success, txHash } = pushTx(txHex)
    console.log("success:", success, "txHash:", txHash)

  } catch (err) {
    console.error(err)
  }
})()
