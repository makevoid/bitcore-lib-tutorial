# rewrite using a dsl dialect

# TODO: implement DSL, run via opal

def require(module)
  # call node's require
end

def File.read
  "...."
end

def bitcore
  obj = Object.new
  def obj.private_key
    "K..."
  end
  def obj.transaction
    "x...."
  end
end

def bitcore.privatekey

end

# ----

# final code:

bitcore = require('bitcore-lib')
PrivateKey  = bitcore.private_key
Transaction = bitcore.transaction

pvt_key_string = File.read.strip()
pvt_key = PrivateKey.new pvt_key_string

address = pvt_key.toAddress()

puts "private key: ${pvt_key}"


# ----

const { readFileSync } = require('fs')
const bitcoin = require('bitcore-lib')
const { PrivateKey, Transaction } = bitcoin

const pvtKeyString = readFileSync('./private-key.txt').toString().trim()
const pvtKey = new PrivateKey(pvtKeyString)

const address = pvtKey.toAddress().toString()

console.log("private key:", pvtKey.toString())
console.log("address:", address)

// --- 6 lines

const getUTXOs  = require('./blockchain-api/get-utxos')
const pushTx    = require('./blockchain-api/push-tx')
// const { pushTx, getUTXOs } = require('./blockchain-api') // TODO: NPM MODULE

;(async () => {
  try {
    let utxos = await getUTXOs({ address })

    utxos = [ utxos[0] ]

    console.log("utxos:", utxos)

    const amount = 10000 // 10k sats (0.1mbtc)

    const tx = new Transaction()
      .from(utxos)
      .to(address, amount)
      .change(address)
      .fee(1000)
      .sign(pvtKey)

    const txHex = tx.serialize()

    console.log("tx:", txHex)

    const { success, txHash } = pushTx(txHex)
    console.log("success:", success, "txHash:", txHash)

  } catch (err) {
    console.error(err)
  }
})()
