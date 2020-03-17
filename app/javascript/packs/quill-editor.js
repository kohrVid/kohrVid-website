import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import ImageResize from "@taoqf/quill-image-resize-module/image-resize.min";
import Quill from 'quill/quill';
export default Quill;

Quill.register('modules/imageResize', ImageResize);


document.addEventListener("DOMContentLoaded", function (event) {
  var quill = new Quill('#editor-container', {
    modules: {
      toolbar: [
        [{ header: [1, 2, 3, 4, 5, 6, false] }],
        [{ 'color': [] }],
        ['bold', 'italic', 'underline', 'strike', { 'script': 'super'}, {'script': 'sub'}, 'code', 'link'],
        ['blockquote', 'code-block', 'image'],
        [{ list: 'ordered' }, { list: 'bullet' }],
        [{ align: ['center', 'right', 'justify', false] }],
        [{ 'indent': '-1'}, { 'indent': '+1' }]
      ],
      imageResize: {
        displayStyles: {
          backgroundColor: 'black',
          border: 'none',
          color: 'white'
        },
        modules: [ 'Resize', 'DisplaySize', 'Toolbar' ]
      }
    },
    value: document.querySelector('input[class=rich-text-content]').value,
    theme: 'snow'
  });
  var form = document.querySelector('form');
  form.onsubmit = function () {
    var body = document.querySelector('input[class=rich-text-content]');
    body.value = quill.root.innerHTML
  };
});
