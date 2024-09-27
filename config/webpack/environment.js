const { environment } = require('@rails/webpacker')

// Add an entry point for the main application file
environment.entry = {
  application: './app/javascript/packs/application.js'
}

module.exports = environment
