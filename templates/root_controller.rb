run 'rm public/index.html'
run 'rm public/images/rails.png'

generate :controller, 'root', 'root'
route "root :to => 'root#root'"

run 'rm app/views/root/root.html.haml'
file 'app/views/root/root.html.haml', <<-END
#hello
  Hello from your new app!
END