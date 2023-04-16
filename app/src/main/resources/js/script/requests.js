function stopApplication() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                console.log("App stopped")
            }
            if (this.status === 404) {
                var message = "Couldn't stop the app";
                console.error(message);
                alert(message);
            }
        }
    };
    xhttp.open("POST", "http://localhost:"+port_number+"/stop", true);
    xhttp.send();
}

function readAccounts() {
    var xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
            }
            var banksIdComboBox = "<div id=\"accounts-list\" class=\"dropdown-content\">";

            var accountList = JSON.parse(this.responseText);
            for (var i = 0; i < accountList.length; i++) {
                var id = accountList[i].id;
                banksIdComboBox += "<a href=\"" + "#" + "\">" + id + "</a>";
            }
            banksIdComboBox += "</div>";

            document.getElementById("accounts-list").innerHTML = banksIdComboBox;
            document.getElementById("src-accounts-list").innerHTML = banksIdComboBox;
            document.getElementById("dest-accounts-list").innerHTML = banksIdComboBox;
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

function readBanks() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                var banksIdComboBox = "<div id=\"accounts-list\" class=\"dropdown-content\">";

                var banksList = JSON.parse(this.responseText);
                for (var i = 0; i < banksList.length; i++) {
                    var id = banksList[i].id;
                    banksIdComboBox += "<a href=\"" + "#" + "\">" + id + "</a>";
                }
                banksIdComboBox += "</div>";

                document.getElementById("banks-list").innerHTML = banksIdComboBox;
            }
            if (this.status === 404) {
                var message = "Couldn't read banks";
                console.error(message);
                alert(message);
            }
        }
    };
    xhttp.open("GET", "http://localhost:" + port_number + "/banks", true);
    xhttp.send();
}

function readTransfers() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                console.log("Reading transfers")
                console.log(this.responseText);

                var table = "<thead><td class='table-td'>id</td><td class='table-td'>from</td><td class='table-td'>to</td>" +
                    "<td class='table-td'>units</td><td class='table-td'>internal</td></thead>";

                var transferList = JSON.parse(this.responseText);

                for (var i = 0; i < transferList.length; i++) {
                    var id = transferList[i].id;
                    var units = transferList[i].units;
                    var internal = transferList[i].internal;
                    var from = transferList[i].srcAccount.shortname;
                    var to = transferList[i].destAccount.shortname;

                    table += "<tr><td class='table-td'>" + id + "</td><td class='table-td'>" + from
                        + "</td><td class='table-td'>" + to + "</td>" + "</td><td class='table-td'>" + units
                        + "</td><td class='table-td'>" + internal + "</td></tr>";
                }

                document.getElementById("transfers-table").innerHTML = table;

            }
            if (this.status === 404) {
                var message = "Couldn't read transfers";
                console.error(message);
                alert(message);
            }
        }
    };
    xhttp.open("GET", "http://localhost:" + port_number + "/transfers", true);
    xhttp.send();
}
