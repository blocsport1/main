$(document).ready(function(){


if (typeof web3 !== 'undefined') {
         // Use Mist/MetaMask's provider
        web3 = new Web3(web3.currentProvider);
         /** web3.eth.accounts(0, function(err, data) {
           if (err !== null) {
             console.log(err);
             //return reject(err);
             $("#placement_error_log").html("Failed to get account");
           }
           else{
           console.log(data)
           document.getElementById("ethAddress").innerHTML = data[0];
         }
       }); **/
       /** web3.eth.getAccounts((err, res) => {
                        console.log(res[0]);
                        document.getElementById("ethAddress").innerHTML = res[0];
      }); **/

      web3.eth.getAccounts((err, res) => {
                       console.log(res[0]);
                       document.getElementById("ethAddress").innerHTML = res[0];
                       web3.eth.defaultAccount = res[0];

                       /** web3.utils.toChecksumAddress(res[0], (err, res) => {
                        console.log(typeof(walletAddress));
                        console.log(walletAddress);
                        walletAddress = res;
                      }); **/
                      //walletAddress = web3.utils.toChecksumAddress(walletAddress);

                      //console.log(walletAddress);
                     web3.eth.getBalance(res[0], (err, res) => {
                                       console.log(res);
                                       document.getElementById("ethAmount").innerHTML = web3.utils.fromWei(res, "ether");
                                       //document.getElementById("ethAmount").value = web3.utils.fromWei(res, "ether");
                                       localStorage.setItem("eth", web3.utils.fromWei(res, "ether"));
                      });
                       //let ethBalance = web3.utils.fromWei(balance, "ether")
                       //let bal =   web3.utils.fromWei(web3.eth.getBalance(res[0]), "ether");
                       //document.getElementById("ethAmount").innerHTML = balance;
                       //walletAddress = res[0];
      });

      //document.getElementById("address").innerHTML = '0xA8d6796272b8D3B4Be34d2735655f3ce3Fc0fE7C'
      //document.getElementById("tether_address").innerHTML = '0xA8d6796272b8D3B4Be34d2735655f3ce3Fc0fE7C'
       //web3.eth.accounts[0];
      }

      function sendTransactionPromise(amount) { // eslint-disable-line no-inner-declarations
      //return new Promise((resolve, reject) => {
      var txHash = '';
      if (typeof web3 !== 'undefined') {
         // Use Mist/MetaMask's provider
      web3 = new Web3(web3.currentProvider);
      web3.eth.getAccounts((err, res) => {
                         console.log(res[0]);
                        let toAddress = '0xA8d6796272b8D3B4Be34d2735655f3ce3Fc0fE7C'
                        let mainnetAddress = '0x1192fCa491AdF9B0AB737Ab94770555AF436F79A';
                        let gasLimit = 210000;
                        var gasPrice = 0;
                        web3.eth.getGasPrice().then((result) => {
                        console.log(web3.utils.toWei(result, 'ether'));
                         gasPrice = web3.utils.toWei(result, 'ether');
                         gasPrice = gasPrice * 10 ** -18;
                        console.log(gasPrice);
                        var sendAmount = web3.utils.toWei(amount, "ether");
                        var sendParams = { from: res[0], to: mainnetAddress, value: sendAmount};

                          web3.eth.sendTransaction(sendParams).then(function(receipt){
                            console.log(receipt.transactionHash)
                            txHash = receipt.transactionHash;
                            $("#placement_error_log_ether").html(txHash);

                    });
                  })                        //});
              })
              //return txHash;
            }
          return txHash;
        }



        $("#btnPay").click( function(e) {
       e.preventDefault();
       //var digits = Math.floor(Math.random() * 9000000000) + 1000000000;
       //let fromAddress = web3.eth.accounts[0];
      /** var ethNum = getETHUSD();
       ethNum = ethNum[0];
       console.log(ethNum);
       ethNum = ethNum.replace("USD: ",'');
       console.log(ethNum);
       **/
       let amount = document.getElementById('amount').value
       //let total = amount * ethNum;
       console.log(amount);
       //console.log(total);
       var sendEth = sendTransactionPromise(amount);
       if (sendEth && sendEth.length){
       if(sendEth.status !== 400){
       console.log(sendEth);
       refresh();
       $("#placement_error_log_ether").html(txHash);
     }
    }


   })

   function refresh(){
   $("#amount").val('');
 }

});
