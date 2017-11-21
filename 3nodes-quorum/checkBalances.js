function checkBalance(x) {
	var acct = eth.accounts[x];
        var acctBal = web3.fromWei(eth.getBalance(acct), "ether");
        console.log("  eth.accounts[" + x + "]: \t" + acct + " \tbalance: " + acctBal + " ether");
}

function checkAllBalances() {
    var totalBal = 0;
    for (var acctNum in eth.accounts) {
        var acct = eth.accounts[acctNum];
        var acctBal = web3.fromWei(eth.getBalance(acct), "ether");
        totalBal += parseFloat(acctBal);
        console.log("  eth.accounts[" + acctNum + "]: \t" + acct + " \tbalance: " + acctBal + " ether");
    }
    console.log("  Total balance: " + totalBal + " ether");
};

//eth.sendTransaction({from: eth.accounts[0], to: eth.accounts[1], value: web3.toWei(10, "ether")});
//eth.getTransaction('0x44eefa9a35bef1f84ca9385e69815c492b59791ef485b2f3ff62b90e030837e7');