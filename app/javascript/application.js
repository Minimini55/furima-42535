// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

document.addEventListener("turbo:load", () => {
  console.log("Turbo has successfully loaded!");
});

import "controllers"
import "price"
import "card"
