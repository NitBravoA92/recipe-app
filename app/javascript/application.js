// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.querySelector(".toggle").addEventListener("click", function(event) {
  const navItems = document.querySelectorAll(".nav-item");
  for (const item of navItems) {
    item.classList.toggle("active");
  }
});
