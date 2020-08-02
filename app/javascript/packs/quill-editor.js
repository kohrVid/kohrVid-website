import { DirectUpload } from "@rails/activestorage"
import ImageResize from "@taoqf/quill-image-resize-module/image-resize.min";
import Quill from 'quill/quill';
export default Quill;

Quill.register('modules/imageResize', ImageResize);

const MAX_FILE_SIZE = 1000000

const basicToolbar = (document) => ({
  modules: {
    toolbar: [
      [{ header: [1, 2, 3, 4, 5, 6, false] }],
      [{ color: [] }],
      [{ size: [] }],
      [
        'bold', 'italic', 'underline', 'strike',
        { 'script': 'super'},
        { 'script': 'sub' },
        'code', 'link'
      ],
      ['blockquote', 'code-block'],
      [{ list: 'ordered' }, { list: 'bullet' }],
      [{ align: ['center', 'right', 'justify', false] }],
      [{ indent: '-1'}, { indent: '+1' }]
    ],
  },
  value: document.querySelector('input[class=rich-text-content]').value,
  theme: 'snow',
  formats: [
    'background', 'bold', 'color', 'font', 'code', 'italic', 'link', 'size',
    'strike', 'script', 'underline', 'blockquote', 'header', 'indent', 'list',
    'align', 'direction', 'code-block', 'formula']
});


document.addEventListener("DOMContentLoaded", function (event) {
  let quill;

  if (document.getElementById("editor-container-strict") !== null) {
    quill = renderBasicEditor(basicToolbar(document))
  } else {
    quill =  renderExtendedEditor(basicToolbar(document))
  }

  document.querySelector('form').onsubmit = function () {
    var body = document.querySelector('input[class=rich-text-content]');
    body.value = quill.root.innerHTML
  };
});

let renderExtendedEditor = function (basicToolbar) {
  basicToolbar.modules.toolbar[4].push('image');
  basicToolbar.formats.push('image');

  basicToolbar.modules.imageResize = {
    displaySize: true,
    displayStyles: {
      backgroundColor: 'black',
      border: 'none',
      color: 'white'
    },
    modules: [ 'Resize', 'DisplaySize', 'Toolbar' ]
  };

  let quill = renderBasicEditor(basicToolbar, '#editor-container', true);

  quill.getModule('toolbar').addHandler('image', () => {
    importImage(quill);
  });

  return quill
}

let renderBasicEditor = function (
  basicToolbar,
  div='#editor-container-strict',
  allowImages=false
) {
  let quill = new Quill(div, basicToolbar)

  if (!allowImages) {
    quill.on('text-change', function (delta, oldDelta, source) {
      $(`${div} img`).remove();
    });
  }

  return quill
};

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

  var upload = new DirectUpload(file, '/rails/active_storage/direct_uploads')
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
