import "bootstrap";
import { encryptCard } from '../components/moip';
import { keyFromActiveRecord } from '../components/moip';
import { validateCreditCard } from '../components/moip';
import { installCheck } from '../components/form_check';


$(document).ready(function() {
$('.thumbnail').click(function(){
      $('.modal-body').empty();
  	$($(this).parents('div').html()).appendTo('.modal-body');
  	$('#myModal').modal({show:true});
});
});

console.log(keyFromActiveRecord);

encryptCard();
validateCreditCard();
// installCheck();
