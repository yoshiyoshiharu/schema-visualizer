document.addEventListener('turbo:submit-end', function() {
  setTimeout(function() {
    document.getElementById("alert").classList.remove('show');
  }, 2000);
});
