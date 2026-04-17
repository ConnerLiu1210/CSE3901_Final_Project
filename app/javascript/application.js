// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "controllers"

// Makes flash messages disappear after 2 seconds
const flashAutoDisappear = () => {
    const flashes = document.querySelectorAll('.flash');

    flashes.forEach(flash => {
        setTimeout(() => {
            flash.style.opacity = '0';
            flash.style.transform = 'translateY(-10px)';

            setTimeout(() => {
                flash.remove();
            }, 600);
        }, 2000);
    });
};
// The event listener for flashAutoDisappear
document.addEventListener("DOMContentLoaded", flashAutoDisappear);