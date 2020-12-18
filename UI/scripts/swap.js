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


       //web3.eth.accounts[0];
      }
});
