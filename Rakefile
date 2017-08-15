require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :db do
  desc 'Init cassandra keyspace and model'
  task :keyspace do
  	require 'colorize'
    require 'highline'
    require './lib/running_tracker_cassandra_database'

    begin
      cli = HighLine.new
      convert = -> (str) { str =~ /^y$/i }
      message = "Are you trying to create the keyspace for cassandra ? (y / n)"
      agree = cli.ask(message, convert) { |q| q.validate = /^(y|n)$/i }

      if agree
      	cluster = cli.ask('Cluster: ') { |q| q.default = "127.0.0.1" }
        keyspace = cli.ask('keyspace: ') { |q| q.default = "running_tracker" }

        cluster = { hosts: [cluster] }

        puts 'Connecting...'.blue
        session = RunningTrackerCassandraDatabase.connect({ 'cluster' => cluster })

        puts 'Running keyspace construction...'.blue
        RunningTrackerCassandraDatabase.construct_keyspace!(session)
        puts 'Keyspace constructed successfully'.green


        puts 'Connecting to keyspace...'.blue
        session = RunningTrackerCassandraDatabase.connect({ 'cluster' => cluster, 'keyspace' => keyspace })

        puts 'Running models construction...'.blue
        RunningTrackerCassandraDatabase.construct_models!(session)

        puts 'Done!!'.green
      else
        puts 'Bye'.green
      end
    rescue => e
      puts "ERROR: #{e.inspect}".red
      puts "In: #{e.backtrace.join("\n    ")}"
    end
  end
end

