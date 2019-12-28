# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

unless Rails.env.production?
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'

  task ci_check: %i[rubocop spec]

  RuboCop::RakeTask.new
  RSpec::Core::RakeTask.new(:spec)
end
