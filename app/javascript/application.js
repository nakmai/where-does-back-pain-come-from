// app/javascript/application.js
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import axios from 'axios';

import { Turbo } from "@hotwired/turbo-rails"
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import Rails from "@rails/ujs"

Rails.start()
import "pain_behavior_myofascial_back_pain"

document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  axios.defaults.headers.common['X-CSRF-Token'] = token;
});

