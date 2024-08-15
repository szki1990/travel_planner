// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require rails-ujs


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {
 
  const iconElements = document.querySelectorAll('.icon-selection i');
  const iconSelect = document.getElementById('icon-select');
  
  iconElements.forEach(icon => {
    icon.addEventListener('click', () => {
      const selectedIconClass = icon.getAttribute('data-icon');
      iconSelect.value = selectedIconClass;
      iconElements.forEach(el => el.classList.remove('selected'));
      icon.classList.add('selected');
    });
  });
});
