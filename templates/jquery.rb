# Install JQuery 1.4.2.
run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.js"
get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js", "public/javascripts/jquery-ui.js"

run 'rm public/javascripts/rails.js'
get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"