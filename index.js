const { readFileSync } = require('fs')
const bitcoin = require('bitcore-lib')
const { PrivateKey, Transaction } = bitcoin

const pvtKeyString = readFileSync('./private-key.txt').toString().trim()
const pvtKey = new PrivateKey(pvtKeyString)

const address = pvtKey.toAddress().toString()

console.log("private key:", pvtKey.toString())
console.log("address:", address)

// const getUTXOs = require('blockchain-api/get-utxos')
const getUTXOs = require('./blockchain-api/get-utxos')

;(async () => {
  try {
    let utxos = await getUTXOs({ address })

    // TODO: replace with actual input selection or disable (uncomment)
    // NOTE: the current code selects always the first spendable input (usually the latest transaction, as it's using the blockchain.info `/unspent` endpoint)
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
