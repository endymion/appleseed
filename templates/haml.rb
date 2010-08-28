gem 'haml'

run 'bundle install'

run 'haml --rails .'

run 'git clone git://github.com/psynix/rails3_haml_scaffold_generator.git lib/generators/haml'

gsub_file 'config/application.rb', /\send\nend/, %{
  config.generators do |g|
    g.template_engine :haml
  end
  
  end
end
}

run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.haml', <<-END
!!!
%html
  %head
    %title [INSERT TITLE HERE]
    = stylesheet_link_tag 'compiled/screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'compiled/print.css', :media => 'print'
    /[if lt IE 8]
      = stylesheet_link_tag 'compiled/ie.css', :media => 'screen, projection'
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body.bp.two-col
    #container
      = yield
END