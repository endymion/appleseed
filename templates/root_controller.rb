run 'rm public/index.html'
run 'rm public/images/rails.png'

generate :controller, 'root', 'root'
route "root :to => 'root#root'"

append_file 'app/stylesheets/screen.scss', <<-END

// Added by Appleseed to make the default sections more visible.  You should probably remove this.
body.two-col {
  #container {
    @include showgrid
  }
  #header, #footer {
    background-color: #DDD;
    margin-top: 1em;
    margin-bottom: 1em;
  }
  #content {
    background-color: #EEE;
  }
}
END

run 'rm app/views/layouts/application.html.haml'
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
      #header
        This header is in the layout template in app/views/layouts/application.html.haml
      = yield
      #footer
        This footer is in the layout template in app/views/layouts/application.html.haml
END

run 'rm app/views/root/root.html.haml'
file 'app/views/root/root.html.haml', <<-END
#sidebar
  %p
    This sidebar is in the root action template, in the root controller, in app/views/root/root.html.html
  %p
    %ul
      %li navigation
      %li home
      %li contact
      %li etc
#content
  %h1
    Welcome to your new web site!
  %p
    This content copy is in the root action template, in the root controller, in app/views/root/root.html.html
  %p
    This web site is powered by a Rails 3 web application.  Lots of documentation is available
    for Rails.  Start
    %a{:href => 'http://weblog.rubyonrails.org/2010/8/28/rails-has-great-documentation'} here.
  %p
    This page is styled using
    %a{:href => 'http://www.blueprintcss.org/'} Blueprint.
    You can see
    demos of what Blueprint can provide,
    %a{:src => 'http://www.blueprintcss.org/tests/'} here.
    This project uses the Compass implementation of Blueprint in SCSS, documented
    %a{:src => 'http://compass-style.org/docs/reference/blueprint/'} here.
  %p
    The CSS styling for this page was generated from the SCSS file in
    app/stylesheets/screen.scss.  There is a section at the bottom of the file that activates
    the grid and the background colors on the various page sections provided by the Blueprint
    styles directly above it.  You probably want to start your web site project by locating
    that file and removing the grid and background colors.  That file is where you should
    start adding your custom styles.
  %p
    Place your images into public/images.
END