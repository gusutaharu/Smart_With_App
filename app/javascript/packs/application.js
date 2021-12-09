// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../styles/application.scss";
import "../src/preview.js";
import "../src/form_data.js";
import "../src/img_zoom.js";
import "../src/icon_preview.js";
import "../src/answer_preview.js";
import "../src/category.js";
import "../src/section_title.js";
import "../src/save_acitve.js";

window.Cookies = require("js-cookie")

require("bootstrap");

Rails.start()
Turbolinks.start()
ActiveStorage.start()
