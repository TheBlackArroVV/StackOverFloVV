# config valid for current version and patch releases of Capistrano
lock "~> 3.10.2"

set :application, "StackOverFlow"
set :repo_url, "git@github.com:TheBlackArroVV/StackOverFloVV.git"
set :deploy_to, '/var/www/my-app-name'
set :use_sudo, true

# Default branch is :master
ask :deploy, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/web/stackoverflovv"
set :deploy_user, 'web'

# Default value for :linked_files is []
append :linked_files, "config/database.yml", ".env"#, "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end