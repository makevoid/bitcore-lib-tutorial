### bitcore-lib-tutorial

This sameple code will let you generate a private key, create a transaction and submit it via with bitcore-lib and Javascript

---

Creating a private key and sending a bitcoin transaction in 30 lines of code

- run `node create-key.js` to create a new private key (saved by the script in `private-key.txt`)
- fund the account with 1 millibit or less
- run `node index.js` (by default it will create and submit a transaction paying 0.1 btc to the same address)

The code is the following:

```js
const { readFileSync } = require('fs')
const bitcoin = require('bitcore-lib')
const { PrivateKey, Transaction } = bitcoin

const pvtKeyString = readFileSync('./private-key.txt').toString().trim()
const pvtKey = new PrivateKey(pvtKeyString)

const address = pvtKey.toAddress().toString()

console.log("private key:", pvtKey.toString())
console.log("address:", address)

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

```

Creating a private key and sending a bitcoin transaction in 30 lines of code -  #coding #bitcoin #tx #utxo #bitcoin-tx #bitcoin-utxo

---

notes about js JS bitcoin libraries:


`bitcore-lib.js` (purely didatical version - [this version])

`bitcoinjs-lib.js` (TODO: create a more practical version using bitcoinjs-lib or a wrapper)


---

@makevoid
