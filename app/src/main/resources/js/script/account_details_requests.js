function initAccountDetails() {
    var id = sessionStorage.getItem("accountId");
    document.getElementById("account-id").innerText = "" + id + "";
    loadDebitCards();
    loadCreditCards();
    loadCredits()
}

function loadDebitCards() {
    var id = sessionStorage.getItem("accountId");
    console.log(id);

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status == 200) {
                console.log("Reading accounts not finished");
            }

            var accountIds = "";
            var accountList = JSON.parse(this.responseText);
            for (var i = 0; i < accountList.length; i++) {
                var id = accountList[i].id;

                accountIds += id + "<br/>";
            }

        }
        if (this.status === 404) {
            var message = "Couldn't read accounts";
            console.error(message);
            alert(message);
        }
    };
    xhttp.open("GET", "http://localhost:" + port_number + "/corporate-accounts", true);
    xhttp.send();

}

function loadCreditCards() {
    var id = sessionStorage.getItem("accountId");
    console.log(id);
}

function loadCredits() {
    var id = sessionStorage.getItem("accountId");
    console.log(id);
}
