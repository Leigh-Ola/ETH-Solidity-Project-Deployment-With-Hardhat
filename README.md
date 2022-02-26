# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

# STEPS:
Open your terminal and run this:
```shell
npm init -y
npm install --save-dev hardhat
npm install --save-dev @nomiclabs/hardhat-waffle @nomiclabs/hardhat-ethers ethereum-waffle chai  ethers solidity-coverage
```
Add this to your `hardhat.config.js`:
```javascript
require("@nomiclabs/hardhat-waffle");
require('solidity-coverage');

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.5",
};
```
Add these commands to the scripts in your `package.json`
```json
"build": "hardhat compile",
"test:light": "hardhat test",
"test": "hardhat coverage",
```
----------
Create and edit a `.sol` file in your `/contracts` folder. That's your smart contract.
Next, run this:

```console
npm run build
```
> If you watch your project closely, you will probably notice that a new folder, artifacts, has been created. This is the dist/out folder or whatever you call it in your usual projects. Within this folder, you find two more folders: contracts and MyContract.sol. Within the latter, you find two files, called MyContract.dbg.json and MyContract.json. Especially the last one is interesting because it contains the ABI and byte code of your smart contract. This is the output of the Solidity compiler.
----------
Create and edit your `test` javascript file in the `/test` folder, using Chai.js.

Next, Execute your test.
```shell
npm run test
```
----------
Create a `.js` file in the `/scripts` folder, for deployng your smart contract. Here's an example of such a file:
```javascript
async function main() {
  const MyContract = await ethers.getContractFactory("MyContract");
  const myContract = await MyContract.deploy("My Contract");

  console.log("My Contract deployed to:", myContract.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
});
``` 
Add the following to your `package.json` scripts:
```json
"deploy:local": "hardhat run --network localhost scripts/deployMyContract.js"
"local-testnet": "hardhat node"
```
----------
Open a new terminal and run this:
```shell
npm run local-testnet
```
Hardhat started a local Ethereum network for you and printed out all existing accounts, including their private keys. 

Now, go back to your initial terminal and run: 
```shell
npm run deploy:local
```

## NOTE:
Before attempting to connect to your smart contract from the browser (with [web3.js](https://cdn.jsdelivr.net/npm/web3@latest/dist/web3.min.js), for example), setup Remix ide [here](https://remix.ethereum.org), compile your contract, and deploy it with the "Web3 Provider" option.

Then, setup a GETH client with the following command:
```cmd
geth --http --http.corsdomain="*" --http.api web3,eth,debug,personal,net --vmdebug --datadir <path/to/local/folder/for/test/chain> --dev console
```
In a production setting, it may be wise to specify the allowed domains, rather than using a catch-all "*". For example:
```cmd
geth --http --http.corsdomain="https://remix.ethereum.org" --http.api web3,eth,debug,personal,net --vmdebug --datadir <path/to/local/folder/for/test/chain> --dev console
```
> metamask http.corsdomain value (if required): "chrome-extension://nkbihfbeogaeaoehlefnkodbefgpgknn"

### Congratulations