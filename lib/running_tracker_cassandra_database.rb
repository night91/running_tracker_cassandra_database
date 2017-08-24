require "running_tracker_cassandra_database/version"

require 'cassandra'
require './models/constructor'
require_relative 'data_accessor'

  
module RunningTrackerCassandraDatabase
  def self.connect(settings)
    cluster = connect_cluster(settings)
    cluster.connect(settings['keyspace'])
  end

  def self.connect_cluster(settings)
    cluster = Cassandra.cluster(settings['cluster'])
  end
end
