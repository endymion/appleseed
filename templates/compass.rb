gem "compass"

run 'bundle install'

run 'compass init rails . --using blueprint --sass-dir app/stylesheets --css-dir public/stylesheets/compiled'

run 'compass compile'

gsub_file 'config/environments/production.rb', /^end$/, %{
end

# Don't generate CSS from SCSS in production, because Heroku can't.
Sass::Plugin.options[:never_update] = true
}
