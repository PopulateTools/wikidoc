lock '3.4.0'

set :application, 'loquehicimos.populate.tools'
set :repo_url, 'git@github.com:PopulateTools/wikidoc.git'
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'

set :passenger_restart_with_touch, true
