Iugu.setAccountID("FE1C78A5B10A4CE4A9C9E58FE935E21E");
Iugu.setTestMode(true);

jQuery(function($) {
  $('#payment-form').submit(function(evt) {
      var form = $(this);
      var tokenResponseHandler = function(data) {

          if (data.errors) {
              alert("Erro salvando cartão: " + JSON.stringify(data.errors));
          } else {
              $("#token").val( data.id );
              form.get(0).submit();
          }

          // Seu código para continuar a submissão
          // Ex: form.submit();
      }

      Iugu.createPaymentToken(this, tokenResponseHandler);
      return false;
  });
});
