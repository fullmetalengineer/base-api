# frozen_string_literal: true

# Drop, create, migrate, then seed the development database
namespace :db do
  desc 'Drop, create, migrate, then seed the development database'
  task :reseed do
    if Rails.env.production?
      puts 'This task can only be run in development environment'
      exit
    else
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke
      puts 'Reseeding completed.'
    end
  end
end
