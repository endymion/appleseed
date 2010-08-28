run 'rm .gitignore'
file '.gitignore', <<-END
design
.bundle
.DS_Store
log/*.log
tmp/**/*
db/*.sqlite3
END

run 'mkdir design'