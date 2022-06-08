pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js", preload: true
pin "lintity/application"
pin_all_from Lintity::Engine.root.join("app/assets/javascripts/lintity/controllers"), under: "controllers", to: "lintity/controllers"