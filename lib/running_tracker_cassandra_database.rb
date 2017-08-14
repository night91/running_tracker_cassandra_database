require "running_tracker_cassandra_database/version"

require 'cassandra'
require './models/constructor'

module RunningTrackerCassandraDatabase
  def self.connect(settings)
  	cluster = connect_cluster(settings['cluster'])
  	cluster.connect(settings['keyspace'])
  end

  def self.connect_cluster(settings)
  	cluster = Cassandra.cluster
  end
end
