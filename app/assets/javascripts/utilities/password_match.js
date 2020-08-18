document.addEventListener('turbolinks:load', function() {
  var password_selector = document.querySelector('#password-confirmation-field');    
  if (password_selector) {password_selector.addEventListener('input', matchPasswordConfirmation)}  
});

function matchPasswordConfirmation() {

  if (document.getElementById('password-confirmation-field').value == '') {
    document.querySelector('.octicon-thumbsup').classList.add('hide');
    document.querySelector('.octicon-circle-slash').classList.add('hide');
    return ''
  }

  if (document.getElementById('password-field').value != document.getElementById('password-confirmation-field').value) {
    document.querySelector('.octicon-circle-slash').classList.remove('hide');
    document.querySelector('.octicon-thumbsup').classList.add('hide');
  } else {
    document.querySelector('.octicon-thumbsup').classList.remove('hide');
    document.querySelector('.octicon-circle-slash').classList.add('hide');
  }  
}
