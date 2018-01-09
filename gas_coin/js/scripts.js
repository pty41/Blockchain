Web3 = require('web3')
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
code = fs.readFileSync('SmartContract_Gascoin_v1.sol')
solc = require('solc')
compiledCode = solc.compile(code)
abiDefinition = JSON.parse(compiledCode.contracts[':MyToken'].interface)
SmartContract = web3.eth.contract(abiDefinition);
contractInstance = SmartContract.at('0x2a9c1d265d06d47e8f7b00ffa987c9185aecf672');
