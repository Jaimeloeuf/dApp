/*  Script to deploy smart contract onto the test net
*/

// const ganache = require("ganache-core");
// const web3 = new Web3(ganache.provider());

// Web3 library used to interface with the Testnet
const Web3 = require('web3');
// fs library needed to read the contract source file for compilation
const fs = require("fs");
// solc is the Solidity Complier, needed to compile the smart contract before deployment
const solc = require('solc')

// Create a new connection interface
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
const print = console.log;


const input = {
    language: 'Solidity',
    sources: {
        'voting.sol': {
            // Read the code as string before compiling
            content: fs.readFileSync('./src/voting.sol').toString()
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': ['*']
            }
        }
    }
}

const compiledCode = JSON.parse(solc.compile(JSON.stringify(input)))

// `compiledCode` here contains the JSON compiledCode as specified in the documentation
for (var contractName in compiledCode.contracts['voting.sol']) {
    // console.log(contractName + ': ' + compiledCode.contracts['voting.sol'][contractName].evm.bytecode.object)
    // console.log(': ' + compiledCode.contracts['voting.sol']['Voting'].evm.bytecode.object)
}

print("TP1")
const abi = compiledCode.contracts['voting.sol']['Voting'].abi;
print(typeof abi);

VotingContract = new web3.eth.Contract(abi)

byteCode = compiledCode.contracts['voting.sol'].bytecode;


deployedContract = VotingContract.new(['Rama', 'Nick', 'Jose'], { data: byteCode, from: web3.eth.accounts[0], gas: 4700000 })
deployedContract.address
contractInstance = VotingContract.at(deployedContract.address)