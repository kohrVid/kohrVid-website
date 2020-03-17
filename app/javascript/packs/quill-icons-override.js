document.addEventListener("DOMContentLoaded", function (event) {
  var iconsDivs = Array.from(document.getElementsByClassName("ql-picker-label")).
    concat(
      Array.from(document.getElementsByClassName("ql-picker-item")),
      Array.from(document.querySelectorAll(".ql-formats button")),
    )

  iconsDivs.map(function(div) {
    renderSvgIcon(div);
  });
});

var renderSvgIcon = function (div) {
  fileName = div.innerText;
  if (fileName.length > 0) {
    icon = readTextFile(fileName);
    div.innerHTML = icon;
  };
};

var readTextFile = function (file) {
  var rawFile = new XMLHttpRequest();
  rawFile.open("GET", file, false);
  var text = ""

  rawFile.onreadystatechange = function () {
    if(rawFile.readyState === 4) {
      if(rawFile.status === 200 || rawFile.status == 0) {
        text = rawFile.responseText;
      }
    }
  }
  rawFile.send(null);
  return text;
}
