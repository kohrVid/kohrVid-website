window.addEventListener("trix-file-accept", function(event) {
  const acceptedTypes = ['image/jpg', 'image/jpeg', 'image/png']
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault()
    alert("Only support attachment of jpeg or png files")
  }

  const maxFileSize = 1MB
  if (event.file.size > maxFileSize) {
    event.preventDefault()
    alert("Only support attachment files upto size 1MB!")
  }
});
