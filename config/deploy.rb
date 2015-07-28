# If you are using rbenv add these lines:
# require 'capistrano/rbenv'
# set :rbenv_type, :user # or :system, depends on your rbenv setup
# set :rbenv_ruby, '2.0.0-p451'

# If you are using rvm add these lines:
# require 'capistrano/rvm'
# set :rvm_type, :user
# set :rvm_ruby_version, '2.0.0-p451'
#After we've got Capistrano installed, we can configure the config/deploy.rb to setup our general configuration for our app. Edit that file and make it like the following replacing "myapp" with the name of your application and git repository:

set :application, 'wim'
set :repo_url, 'git@github.com:slakat/wim.git'

set :deploy_to, '/home/slakat/wim'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
