import { DirectUpload } from "@rails/activestorage"
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import ImageResize from "@taoqf/quill-image-resize-module/image-resize.min";
import Quill from 'quill/quill';
export default Quill;

Quill.register('modules/imageResize', ImageResize);

const MAX_FILE_SIZE = 1000000

document.addEventListener("DOMContentLoaded", function (event) {
  var quill = new Quill('#editor-container', {
    modules: {
      toolbar: [
        [{ header: [1, 2, 3, 4, 5, 6, false] }],
        [{ 'color': [] }],
        [
          'bold', 'italic', 'underline', 'strike',
          { 'script': 'super'},
          { 'script': 'sub' },
          'code', 'link'
        ],
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

  document.querySelector('form').onsubmit = function () {
    var body = document.querySelector('input[class=rich-text-content]');
    body.value = quill.root.innerHTML
  };

  quill.getModule('toolbar').addHandler('image', () => {
    importImage(quill);
  });
});

var importImage = function (textEditor) {
  const input = document.createElement('input');
  input.setAttribute('type', 'file');
  input.click();

  input.onchange = () => {
    const file = input.files[0];

    // Ensure only images are uploaded
    if (/^image\//.test(file.type)) {
      if (file.size > MAX_FILE_SIZE) {
        alert("Only support attachment files upto size 1MB!")
        return
      }
      uploadImage(textEditor, file);
    } else {
      alert('Only images allowed');
    }
  };
};

var uploadImage = function (textEditor, file) {
  var fd = new FormData();
  fd.append('blob', file);

  var upload = new DirectUpload(file, '/direct_uploads')
  upload.create((error, blob) => {
    if (error) {
      console.log(error)
    } else {
      insertImage(
        textEditor,
        `/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}`
      );
    }
  });
};

var insertImage = function (textEditor, fileUrl) {
  const range = textEditor.getSelection();
  textEditor.insertEmbed(range.index, 'image', fileUrl);
};
