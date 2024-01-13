document.addEventListener('turbo:submit-end', function() {
  setTimeout(function() {
    document.getElementById("alert").style.display = "none";
  }, 2000);
});
