import assert from "assert"
import { Given, When, Then } from "@cucumber/cucumber"

function isItFriday(today) {
    if (today === "Friday") {
      return "TGIF";
    } else {
      return "Nope";
    }
  }
  
  Given('today is {string}', function (givenDay) {
    this.today = givenDay;
  });
  
  When('I ask whether it\'s Friday yet', function () {
    this.actualAnswer = isItFriday(this.today);
  });
  
  Then('I should be told {string}', function (expectedAnswer) {
    assert.strictEqual(this.actualAnswer, expectedAnswer);
  });