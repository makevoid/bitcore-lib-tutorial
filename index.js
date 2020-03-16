const { readFileSync } = require('fs')
const bitcoin = require('bitcore-lib')
const { PrivateKey, Transaction } = bitcoin

const pvtKeyString = readFileSync('./private-key.txt').toString().trim()
const pvtKey = new PrivateKey(pvtKeyString)

const address = pvtKey.toAddress().toString()

console.log("private key:", pvtKey.toString())
console.log("address:", address)

// --- 6 lines

const { utxos } = require('blockchain-api-basic')

;(async () => {
  const unspent = await utxos(address)

  console.log("utxos:", unspent)

  const amount = 100000 // 100k sats (1mbtc)

  const tx = new Transaction()
    .from(unspent)
    .to(address, amount)
    .change(address)
    .fee(1000)
    .sign(pvtKey)

  const txHex = tx.serialize()

  console.log("tx:", txHex)

  const { success, txHash } = pushTx(txHex)
  console.log("success:", success, "txHash:", txHash)

})()
