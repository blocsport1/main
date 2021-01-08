var express = require('express');
var bodyParser = require('body-parser');
var Web3 = require('web3');
var path = require('path');
var BlockSportOneTokenABI = require('./blocksportone');
var UniSwapContractABI = require('./uniswapcontract');
const provider = require('./provider');
const contractAddresses = require('./contractAddresses');
const cors = require('cors');
var BigNumber = require('big-number');
var Contract = require('web3-eth-contract');

require('dotenv').config()
const Tx = require('ethereumjs-tx').Transaction
var app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

var web3 = new Web3(new Web3.providers.HttpProvider(provider.provider));
const privateKey =  Buffer.from(process.env.PRIVATE_KEY, 'hex');
Contract.setProvider(provider.rinkebyWebSocket);
//const sproutInsureAddPolicyAddress = '0x09E13e6E27B0ae8B18B862228E9cD026BbBF8608';
//var SproutInsureAddPolicyABI = SproutInsureAddPolicy.abi;
//const SproutInsureAddPolicyContract =  new web3.eth.Contract(SproutInsureAddPolicy.SproutInsureAddPolicy, sproutInsureAddPolicyAddress);
const UniSwapContract = new Contract(UniSwapContractABI.uniswapcontract, contractAddresses.RinkebyUniSwapAddress);
const BlockSportOneContract = new Contract(BlockSportOneTokenABI.blocksportone, contractAddresses.RinkebyBlockSportOne);
const UniSwapContractMain = new Contract(UniSwapContractABI.uniswapcontract, contractAddresses.MainnetUniSwapAddress);
const BlockSportOneContractMain = new Contract(BlockSportOneTokenABI.blocksportone, contractAddresses.MainnetBlockSportOne);



function setEtherPrice(etherPrice) {
   etherPrice = etherPrice * 100;
  return new Promise((resolve, reject) => {
    const addr = contractAddresses.RinkebyAdmin;
    web3.eth.getTransactionCount(addr, function(error, txCount) {
    console.log(txCount);
    const encoded = UniSwapContract.methods.setEthPrice(etherPrice).encodeABI();
    var rawTransaction = {
      "nonce": web3.utils.toHex(txCount),
      "gasPrice": "0x04e3b29200",
      "gasLimit": "0xF458F",
      "to": contractAddresses.RinkebyUniSwapAddress,
      "value": "0x0",
      "data": encoded
    };

    var privKey = privateKey
    var tx = new Tx(rawTransaction,  {'chain':'rinkeby'});

    tx.sign(privKey);
    var serializedTx = tx.serialize();

    web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'), (err, hash) => {
      if(err) {
        console.log(err)
        reject(new Error(err.message))
      }
      console.log(hash);
      resolve(hash)
    })
  })
})
}



app.post('/api/uniswap/setEthPrice', async function(req, res){
  try
  {
    //web3.setProvider(new Web3.providers.HttpProvider(provider));
    console.log(req.body);
    const ethPrice = req.body.eth_price;
    const execSetEthPrice = await setEtherPrice(ethPrice);
    res.send({
      status: "accepted",
      success: true,
      error: false,
      status_code : 200,
      data : {
        txHash: execSetEthPrice
      }
    });
  } catch(err) {
    console.log('err' + err.message);
    res.status(500).send({
      status:"error",
      success:false,
      error: true,
      status_code : 500,
      data :{
        error_message: err.message
       }
    });
  }
  finally{
    var setEthPriceTime = new Date(Date.now()).toUTCString();
    console.log("swap.js [setEthPrice] Executed at UTC Time :" + setEthPriceTime);
  }
})


function setEtherPriceMain(etherPrice) {
   etherPrice = etherPrice * 100;
  return new Promise((resolve, reject) => {
    const addr = contractAddresses.MainnetAdmin;
    web3.eth.getTransactionCount(addr, function(error, txCount) {
    console.log(txCount);
    const encoded = UniSwapContractMain.methods.setEthPrice(etherPrice).encodeABI();
    var rawTransaction = {
      "nonce": web3.utils.toHex(txCount),
      "gasPrice": "0x04e3b29200",
      "gasLimit": "0xF458F",
      "to": contractAddresses.MainnetUniSwapAddress,
      "value": "0x0",
      "data": encoded
    };

    var privKey = privateKey
    var tx = new Tx(rawTransaction,  {'chain':'mainnet'});

    tx.sign(privKey);
    var serializedTx = tx.serialize();

    web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'), (err, hash) => {
      if(err) {
        console.log(err)
        reject(new Error(err.message))
      }
      console.log(hash);
      resolve(hash)
    })
  })
})
}



app.post('/api/uniswap/setEthPriceMain', async function(req, res){
  try
  {
    //web3.setProvider(new Web3.providers.HttpProvider(provider));
    console.log(req.body);
    const ethPrice = req.body.eth_price;
    const execSetEthPrice= await setEtherPriceMain(ethPrice);
    res.send({
      status: "accepted",
      success: true,
      error: false,
      status_code : 200,
      data : {
        txHash: execSetEthPrice
      }
    });
  } catch(err) {
    console.log('err' + err.message);
    res.status(500).send({
      status:"error",
      success:false,
      error: true,
      status_code : 500,
      data :{
        error_message: err.message
       }
    });
  }
  finally{
    var setEthPriceTime = new Date(Date.now()).toUTCString();
    console.log("swap.js [setEthPriceMain] Executed at UTC Time :" + setEthPriceTime);
  }
})


function tetherRecieved(investor, amount) {
   //etherPrice = etherPrice * 100;
   const decimals = 6;
  return new Promise((resolve, reject) => {
    const addr = contractAddresses.RinkebyAdmin;
    web3.eth.getTransactionCount(addr, function(error, txCount) {
    console.log(txCount);
    const gasPrice = 100000000000;
    const gasLimit = 210000;
    const encoded = UniSwapContract.methods.tetherRecieved(investor, amount, decimals).encodeABI();
    var rawTransaction = {
      "nonce": web3.utils.toHex(txCount),
      "gasPrice": web3.utils.toHex(gasPrice),
      "gasLimit": web3.utils.toHex(gasLimit),
      "to": contractAddresses.RinkebyUniSwapAddress,
      "value": "0x0",
      "data": encoded
    };

    var privKey = privateKey
    var tx = new Tx(rawTransaction,  {'chain':'rinkeby'});

    tx.sign(privKey);
    var serializedTx = tx.serialize();

    web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'), (err, hash) => {
      if(err) {
        console.log(err)
        reject(new Error(err.message))
      }
      console.log(hash);
      resolve(hash)
    })
  })
})
}



app.post('/api/uniswap/tetherRecieved', async function(req, res){
  try
  {
    //web3.setProvider(new Web3.providers.HttpProvider(provider));
    console.log(req.body);
    const {investor,amount} = req.body;
    const execTetherRecieved = await tetherRecieved(investor,amount);
    res.send({
      status: "accepted",
      success: true,
      error: false,
      status_code : 200,
      data : {
        txHash: execTetherRecieved
      }
    });
  } catch(err) {
    console.log('err' + err.message);
    res.status(500).send({
      status:"error",
      success:false,
      error: true,
      status_code : 500,
      data :{
        error_message: err.message
       }
    });
  }
  finally{
    var tetherRecievedTime = new Date(Date.now()).toUTCString();
    console.log("swap.js [tetherRecieved] Executed at UTC Time :" + tetherRecievedTime);
  }
})


function tetherRecievedMain(investor, amount) {
   //etherPrice = etherPrice * 100;
   const decimals = 6;
  return new Promise((resolve, reject) => {
    const addr = contractAddresses.RinkebyAdmin;
    web3.eth.getTransactionCount(addr, function(error, txCount) {
    console.log(txCount);
    const gasPrice = 100000000000;
    const gasLimit = 210000;
    const encoded = UniSwapContractMain.methods.tetherRecieved(investor, amount, decimals).encodeABI();
    var rawTransaction = {
      "nonce": web3.utils.toHex(txCount),
      "gasPrice": web3.utils.toHex(gasPrice),
      "gasLimit": web3.utils.toHex(gasLimit),
      "to": contractAddresses.MainnetUniSwapAddress,
      "value": "0x0",
      "data": encoded
    };

    var privKey = privateKey
    var tx = new Tx(rawTransaction,  {'chain':'mainnet'});

    tx.sign(privKey);
    var serializedTx = tx.serialize();

    web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'), (err, hash) => {
      if(err) {
        console.log(err)
        reject(new Error(err.message))
      }
      console.log(hash);
      resolve(hash)
    })
  })
})
}



app.post('/api/uniswap/tetherRecievedMain', async function(req, res){
  try
  {
    //web3.setProvider(new Web3.providers.HttpProvider(provider));
    console.log(req.body);
    const {investor,amount} = req.body;
    const execTetherRecieved = await tetherRecievedMain(investor,amount);
    res.send({
      status: "accepted",
      success: true,
      error: false,
      status_code : 200,
      data : {
        txHash: execTetherRecieved
      }
    });
  } catch(err) {
    console.log('err' + err.message);
    res.status(500).send({
      status:"error",
      success:false,
      error: true,
      status_code : 500,
      data :{
        error_message: err.message
       }
    });
  }
  finally{
    var tetherRecievedTime = new Date(Date.now()).toUTCString();
    console.log("swap.js [tetherRecieved] Executed at UTC Time :" + tetherRecievedTime);
  }
})

function sendEtherMain(amount){
     ///const amount = req.body.amount;
      web3.eth.getAccounts((err, res) => {
                         console.log(res[0]);
                        let toAddress = contractAddresses.MainnetUniSwapAddress;
                        let gasLimit = 210000;
                        var gasPrice = 0;
                        web3.eth.getGasPrice().then((result) => {
                        console.log(web3.utils.toWei(result, 'ether'));
                         gasPrice = web3.utils.toWei(result, 'ether');
                         gasPrice = gasPrice * 10 ** -18;
                        console.log(gasPrice);
                        var sendAmount = web3.utils.toWei(amount, "ether");
                        var sendParams = { from: res[0], to: toAddress, value: sendAmount};

                          web3.eth.sendTransaction(sendParams).then(function(receipt){
                            console.log(receipt.transactionHash)
                            txHash = receipt.transactionHash;
                            resolve(txHash);
                    });
                  })                        //});
              })
}

app.post('/api/uniswap/sendEtherMain', async function(req, res){
  try
  {
    //web3.setProvider(new Web3.providers.HttpProvider(provider));
    console.log(req.body);
    const amount = req.body.amount;
    const execSendEther = await sendEtherMain(amount);
    res.send({
      status: "accepted",
      success: true,
      error: false,
      status_code : 200,
      data : {
        txHash: execSendEther
      }
    });
  } catch(err) {
    console.log('err' + err.message);
    res.status(500).send({
      status:"error",
      success:false,
      error: true,
      status_code : 500,
      data :{
        error_message: err.message
       }
    });
  }
  finally{
    var SendEtherTime = new Date(Date.now()).toUTCString();
    console.log("swap.js [execSendEther] Executed at UTC Time :" + SendEtherTime);
  }
  })


  async function sendEther(amount){
       ///const amount = req.body.amount;
         const accounts = await web3.eth.getAccounts();
                           console.log(accounts[0]);
                          let toAddress = contractAddresses.RinkebyUniSwapAddress;
                          let gasLimit = 210000;
                          var gasPrice = 100000000000;
                          //const from = await web3.eth.account                         //web3.eth.getGasPrice().then((result) => {
                          //console.log(web3.utils.toWei(result, 'ether'));
                           //gasPrice = web3.utils.toWei(result, 'ether');
                           //gasPrice = gasPrice * 10 ** -18;
                          //console.log(gasPrice);
                          var sendAmount = amount*10**18;//web3.utils.toWei(amount, "ether");
                          var sendParams = { from: accounts[0], to: toAddress, value: sendAmount, gas : gasPrice, gasPrice : gasLimit};

                            web3.eth.sendTransaction(sendParams).then(function(receipt){
                              console.log(receipt.transactionHash)
                              txHash = receipt.transactionHash;
                              resolve(txHash);


                      });
                  //  })                        //});
                //})
  }

  app.post('/api/uniswap/sendEther', async function(req, res){
    try
    {
      //web3.setProvider(new Web3.providers.HttpProvider(provider));
      console.log(req.body);
      const amount = req.body.amount;
      const execSendEther = await sendEther(amount);
      res.send({
        status: "accepted",
        success: true,
        error: false,
        status_code : 200,
        data : {
          txHash: execSendEther
        }
      });
    } catch(err) {
      console.log('err' + err.message);
      res.status(500).send({
        status:"error",
        success:false,
        error: true,
        status_code : 500,
        data :{
          error_message: err.message
         }
      });
    }
    finally{
      var SendEtherTime = new Date(Date.now()).toUTCString();
      console.log("swap.js [execSendEther] Executed at UTC Time :" + SendEtherTime);
    }
    })

    function increaseAllowance(allowance) {
      return new Promise((resolve, reject) => {
        const addr = contractAddresses.RinkebyAdmin;
        web3.eth.getTransactionCount(addr, function(error, txCount) {
        console.log(txCount);
        const encoded = BlockSportOneContract.methods.increaseAllowance(allowance).encodeABI();
        var rawTransaction = {
          "nonce": web3.utils.toHex(txCount),
          "gasPrice": "0x04e3b29200",
          "gasLimit": "0xF458F",
          "to": contractAddresses.RinkebyBlockSportOne,
          "value": "0x0",
          "data": encoded
        };

        var privKey = privateKey
        var tx = new Tx(rawTransaction,  {'chain':'rinkeby'});

        tx.sign(privKey);
        var serializedTx = tx.serialize();

        web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'), (err, hash) => {
          if(err) {
            console.log(err)
            reject(new Error(err.message))
          }
          console.log(hash);
          resolve(hash)
        })
      })
    })
    }



    app.post('/api/uniswap/increaseAllowance', async function(req, res){
      try
      {
        //web3.setProvider(new Web3.providers.HttpProvider(provider));
        console.log(req.body);
        const amount = req.body.amount;
        amount = amount*10**18;
        const execIncreaseAllowance = await increaseAllowance(amount);
        res.send({
          status: "accepted",
          success: true,
          error: false,
          status_code : 200,
          data : {
            txHash: execIncreaseAllowance
          }
        });
      } catch(err) {
        console.log('err' + err.message);
        res.status(500).send({
          status:"error",
          success:false,
          error: true,
          status_code : 500,
          data :{
            error_message: err.message
           }
        });
      }
      finally{
        var increaseAllowanceTime = new Date(Date.now()).toUTCString();
        console.log("swap.js [increaseAllowance] Executed at UTC Time :" + increaseAllowanceTime);
      }
    })


    function increaseAllowanceMain(allowance) {
      return new Promise((resolve, reject) => {
        const addr = contractAddresses.MainnetAdmin;
        web3.eth.getTransactionCount(addr, function(error, txCount) {
        console.log(txCount);
        const encoded = BlockSportOneContractMain.methods.increaseAllowance(allowance).encodeABI();
        var rawTransaction = {
          "nonce": web3.utils.toHex(txCount),
          "gasPrice": "0x04e3b29200",
          "gasLimit": "0xF458F",
          "to": contractAddresses.MainnetBlockSportOne,
          "value": "0x0",
          "data": encoded
        };

        var privKey = privateKey
        var tx = new Tx(rawTransaction,  {'chain':'mainnet'});

        tx.sign(privKey);
        var serializedTx = tx.serialize();

        web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'), (err, hash) => {
          if(err) {
            console.log(err)
            reject(new Error(err.message))
          }
          console.log(hash);
          resolve(hash)
        })
      })
    })
    }



    app.post('/api/uniswap/increaseAllowanceMain', async function(req, res){
      try
      {
        //web3.setProvider(new Web3.providers.HttpProvider(provider));
        console.log(req.body);
        const amount = req.body.amount;
        amount = amount*10**18;
        const execIncreaseAllowance = await increaseAllowanceMain(amount);
        res.send({
          status: "accepted",
          success: true,
          error: false,
          status_code : 200,
          data : {
            txHash: execIncreaseAllowance
          }
        });
      } catch(err) {
        console.log('err' + err.message);
        res.status(500).send({
          status:"error",
          success:false,
          error: true,
          status_code : 500,
          data :{
            error_message: err.message
           }
        });
      }
      finally{
        var increaseAllowanceTime = new Date(Date.now()).toUTCString();
        console.log("swap.js [increaseAllowance] Executed at UTC Time :" + increaseAllowanceTime);
      }
    })


    app.listen(8888, function(err){
      if (!err) {
        console.log("Server is Running on port 8888");
      }
    });
