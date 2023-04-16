package org.kd.main.server.rest.controller;

import org.kd.main.common.entities.CreditCard;
import org.kd.main.server.model.data.dao.CreditCardDaoRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
class CreditCardController {

    private final CreditCardDaoRepo creditCardDao;

    @Autowired
    public CreditCardController(CreditCardDaoRepo creditCardDao) {
        this.creditCardDao = creditCardDao;
    }

    @GetMapping(path = "/creditcard/{id}", produces = APPLICATION_JSON_VALUE)
    public ResponseEntity<CreditCard> read(@PathVariable long id) {
        var creditCard = creditCardDao.read(id);

        return creditCard != null ?
                ResponseEntity
                        .status(HttpStatus.OK)
                        .header("Access-Control-Allow-Origin", "*")
                        .body(creditCard)
                :
                ResponseEntity
                        .status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .header("message", "Couldn't read " + CreditCard.class.getSimpleName() + " with id = " + id)
                        .build();
    }

    @GetMapping(path = "/creditcards")
    public ResponseEntity<List<CreditCard>> readAll() {
        var creditCards = creditCardDao.readAll();

        return creditCards != null ?
                ResponseEntity
                        .status(HttpStatus.OK)
                        .header("Access-Control-Allow-Origin", "*")
                        .body(creditCards)
                :
                ResponseEntity
                        .status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .header("message", "Error reading list of " + CreditCard.class.getSimpleName())
                        .build();
    }

    @GetMapping(path = "/creditcards/{accountId}")
    public ResponseEntity<List<CreditCard>> readAccountCards(@PathVariable Long accountId) {
        var creditCards = creditCardDao.readAccountCards(accountId);

        return creditCards != null ?
                ResponseEntity
                        .status(HttpStatus.OK)
                        .header("Access-Control-Allow-Origin", "*")
                        .body(creditCards)
                :
                ResponseEntity
                        .status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .header("Access-Control-Allow-Origin", "*")
                        .header("message", "Error reading list of "
                                + CreditCard.class.getSimpleName() + "for account " + accountId)
                        .build();
    }
}
