import jsencrypt from 'jsencrypt';
import { MoipCreditCard } from 'moip-sdk-js';
import { MoipValidator } from 'moip-sdk-js';


const pubKey = `-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjF7RrjbmrknTuVE17hdG
GevMWGQKoUjLxFLJUNZcMNE5QWL5b7bm4gDEoQGhGUqoime3IHnKEwktLIxTRZRL
24BK2TpZngRQYgAcUAEysHvvd097HmK+kzDQKEOb9/UblNRDvrguDrKzaZM3FGYR
zLAxlwBB/x/4QClpeK18J55GGQBov33O52V4h/XT34yhsjJm+F4C0I5oDsjQ94En
Hg3zbscVxrSZx9Yg9KuwCfqejvFFnuQTOyQQaE/kbCGzUm4QhYCZDKryvcXHctq/
FYYMG7Ou2kPvqWSh5mKkl2hFvJ9nSxXVXkfA3LRLMVn/uPiuzafQf67Fqtw9w0dg
TQIDAQAB
-----END PUBLIC KEY-----`;

const number = document.getElementById('number');
const cvc = document.getElementById('cvc');
const month = document.getElementById('month');
const year = document.getElementById('year');

function validateNumber(){
  if (number){
    number.addEventListener('keyup', function(){
      let response = MoipValidator.isValidNumber(number.value);
      if (response) {
        number.classList.toggle('active');
      }
    });
  }
}

function validateCardExpiration(){
  if (number){
    year.addEventListener('keyup', function(){
      let response = MoipValidator.isExpiryDateValid(month.value, year.value);
      if (response) {
        month.classList.toggle('active');
        year.classList.toggle('active');
      }
    });
  }
}

function validateSecurityCode(){
  if (cvc){
    cvc.addEventListener('keyup', function(){
      let response = MoipValidator.isSecurityCodeValid(number.value, cvc.value);
      if (response) {
        cvc.classList.toggle('active');
      }
    });
  }
}



function validateCreditCard(){
  validateNumber();
  validateCardExpiration();
  validateSecurityCode();
}







function setEncryptedData() {
  let input = document.getElementById('encrypt');

    MoipCreditCard
    .setEncrypter(jsencrypt, 'ionic')
    .setPubKey(pubKey)
    .setCreditCard({
        number: number.value,
        cvc: cvc.value,
        expirationMonth: month.value,
        expirationYear: year.value
    })
    .hash()
    .then(hash => input.value = (hash));
}
function encryptCard(){
  let button = document.getElementById('submit-button');
  if (button) {
    button.addEventListener('click', function(){
      setEncryptedData()
    });
  }
}

// function update() {
//   input.value = encryptCard()[:hash];
// };

// export {update};

export {encryptCard};
export {validateCreditCard};
