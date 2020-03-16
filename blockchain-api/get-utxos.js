const { get } = require('axios')

const bcInfoHost = "https://blockchain.info"
const unspentUrl = (address) => `${bcInfoHost}/unspent?active=${address}&format=json&cors=true`

// convert from blockchain.info format to bitcore-lib utxo format
const convertUTXO = (utxo) => (
  {
    txId: utxo.tx_hash_big_endian,
    vout: utxo.tx_output_n,
    script: utxo.script,
    satoshis: utxo.value,
  }
)

const getUnspentOutputs = async ({ address }) => {
  const url = unspentUrl(address)
  const resp = await get(url)
  const data = resp.data
  if (data == "No free outputs to spend") return []
  if (data == "Invalid Bitcoin Address")  throw Error(`Bitcoin address is not valid - address: ${address}`)
  return data.unspent_outputs
}

// raise an error if there are no spendable outputs
const checkUTXOs = ({ utxos, address }) => {
  utxos = utxos.filter(utxo => utxo.confirmations > 0)
  utxos = utxos.filter(utxo => utxo.value > 1000)
  if (utxos.length == 0) throw Error(`No spendable outputs were found, please fund the address or wait for transactions to confirm - address: ${address}`)
}

const getUTXOs = async ({ address }) => {
  let utxos = await getUnspentOutputs({ address })
  checkUTXOs({ utxos, address })
  utxos = utxos.map(convertUTXO)
  return utxos
}

module.exports = getUTXOs
