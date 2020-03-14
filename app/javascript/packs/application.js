/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import "../css/application.css"
require("@rails/actiontext")
require("@rails/activestorage").start()
import Quill from 'quill/quill';
import ImageResize from "@taoqf/quill-image-resize-module/image-resize.min";

Quill.register('modules/imageResize', ImageResize);

export default Quill;

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
