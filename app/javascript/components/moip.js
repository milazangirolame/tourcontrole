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

function setEncryptedData() {
  let input = document.getElementById('encrypt');
  let number = document.getElementById('number');
  let cvc = document.getElementById('cvc');
  let month = document.getElementById('month');
  let year = document.getElementById('year');
    MoipCreditCard
    .setEncrypter(jsencrypt, 'ionic')
    .setPubKey(pubKey)
    .setCreditCard({
        number: number,
        cvc: cvc,
        expirationMonth: month,
        expirationYear: year
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
