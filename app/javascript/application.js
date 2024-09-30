// app/javascript/application.js
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import Rails from "@rails/ujs"

Rails.start()

