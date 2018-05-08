# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :dictionary do
  task :load => :environment do
    File.open('/usr/share/dict/words')
        .map(&:chomp)
        .reject { |word| word =~ /[A-Z]/ }
        .reject { |word| word.size < 2 || word.size > Word::MAX_SIZE }
        .each { |word| Word.create(original: word) }
  end

  task :delete => :environment do
    Word.delete_all
  end
end
