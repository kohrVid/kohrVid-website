# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
Rake::Task['webpacker:yarn_install'].clear
Rake::Task['webpacker:check_yarn'].clear
Rake::Task.define_task('webpacker:verify_install' => ['webpacker:check_npm'])
Rake::Task.define_task('webpacker:compile' => ['webpacker:npm_install'])
Rake::Task.define_task('assets:precompile' => ['webpacker:npm_install'])
