/*  Script to deploy smart contract onto the test net
*/

// Web3 library used to interface with the Testnet
const Web3 = require('web3');
// fs library needed to read the contract source file for compilation
const fs = require("fs");
// solc is the Solidity Complier, needed to compile the smart contract before deployment
const solc = require('solc')

// Create a new connection interface
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

// Read the code as string before compiling
code = fs.readFileSync('./src/voting.sol').toString();
compiledCode = solc.compile(code);

abiDefinition = JSON.parse(compiledCode.contracts[':Voting'].interface)
VotingContract = web3.eth.contract(abiDefinition)
byteCode = compiledCode.contracts[':Voting'].bytecode
deployedContract = VotingContract.new(['Rama', 'Nick', 'Jose'], { data: byteCode, from: web3.eth.accounts[0], gas: 4700000 })
deployedContract.address
contractInstance = VotingContract.at(deployedContract.address)