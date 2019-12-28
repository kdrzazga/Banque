function readAccount(accountId) {
    var accountName = document.getElementById("account-name");
    var accountShortName = document.getElementById("account-shortname");
    var accountBalance = document.getElementById("account-cash-balance");

    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                var account = JSON.parse(this.responseText);
                console.log("Show account read accountId=" + account.name);
                accountName.value = account.name;
                accountShortName.value = account.shortname;
                accountBalance.value = account.balance;
            }

            if (this.status === 404) {
                var message = "Couldn't read banks";
                console.error(message);
                alert(message);
            }
        }
    };

    var url = "http://localhost:8080/account/" + accountId;
    console.log("request " + url);
    xhttp.open("GET", url, true);
    xhttp.send();
}

function readBank(bankId) {
    var bankName = document.getElementById("bank-name");
    var bankShortName = document.getElementById("bank-short-name");

    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                var bank = JSON.parse(this.responseText);
                console.log("Show bank read bankId=" + bank.name);
                bankName.value = bank.name;
                bankShortName.value = bank.shortname;
            }

            if (this.status === 404) {
                var message = "Couldn't read banks";
                console.error(message);
                alert(message);
            }
        }
    };

    var url = "http://localhost:8080/bank/" + bankId;
    console.log("request " + url);
    xhttp.open("GET", url, true);
    xhttp.send();
}

function readBankAccounts(bankId) {
    var accounts = document.getElementById("bank-accounts");

    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                var associatedAccounts = JSON.parse(this.responseText);
                console.log("Number of accounts read: " + associatedAccounts.length);

                var accountIds = "";
                for (var i = 0; i < associatedAccounts.length; i++) {
                    accountIds += associatedAccounts[i].id + " ";
                }

                accounts.innerText = accountIds;
            }

            if (this.status === 404) {
                var message = "Couldn't read banks";
                console.error(message);
                alert(message);
                return "Error";
            }
        }
    };

    var url = "http://localhost:8080/associatedAccounts/" + bankId;
    console.log("request " + url);
    xhttp.open("GET", url, true);
    xhttp.send();
}

function showAccount() {
    var id = document.getElementById("account-selected-account").innerText;
    readAccount(id);
}

function showBank() {

    var id = document.getElementById("bank-selected-bank").innerText;
    readBank(id);
    readBankAccounts(id);
}

function deleteAccount() {
    var id = document.getElementById("account-selected-account").innerText;
    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                console.log(this.responseText);
                alert("Account " + id + " deleted");
            }

            if (this.status === 404) {
                var message = "Couldn't delete";
                console.error(message);
                alert(message);
            }
        }
    };

    var url = "http://localhost:8080/account/" + id;
    console.log("request " + url);
    xhttp.open("DELETE", url, true);
    xhttp.send();
}

function bookInternalTransfer(srcAccountId, destAccountId, units) {
    console.log("Booking internal transfer of " + units + " from " + srcAccountId + " to " + destAccountId);
    var xhttp = new XMLHttpRequest();

    var newTransfer = {"srcAccountId" : srcAccountId};

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                console.log(this.responseText);
                alert("Transfer " + " booked");
            }

            if (this.status === 404) {
                var message = "Couldn't book";
                console.error(message);
                alert(message);
            }
        }
    };

    var url = "http://localhost:8080/transfer";
    //TODO
    console.log("request " + url);
    xhttp.open("POST", url);
    xhttp.setRequestHeader("Content-Type", "application/json");
    xhttp.send(JSON.stringify(newTransfer));
}

function isTransferInternal(account1, account2){
    return true;//TODO
}

function createTransfer() {
    var srcAccountId = document.getElementById("transfer-selected-source-account").innerText;
    var destAccountId = document.getElementById("transfer-selected-dest-account").innerText;
    var units = document.getElementById("transfer-amount").value;

    if (isTransferInternal(srcAccountId, destAccountId)) {
        bookInternalTransfer(srcAccountId, destAccountId, units);
    }
}
