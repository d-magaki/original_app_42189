// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css";

document.addEventListener("DOMContentLoaded", function() {
  flatpickr("#order_date", { enableTime: false, dateFormat: "Y-m-d" });
  flatpickr("#due_date", { enableTime: false, dateFormat: "Y-m-d" });
});