const getUTXOs = require('./get-utxos')

// test address
const address = "1F9TTRQsk1yz9QHN8EuSVLqS5TYkvzjhR5"

;(async () => {
  try {
    const utxos = await getUTXOs({ address })
    console.log("UTXOs:", utxos)
  } catch (err) {
    console.error(err)
  }
})()
