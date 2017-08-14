require_relative 'keyspace_definition'

module RunningTrackerCassandraDatabase
	class << self
		def construct_models!(database_session)
			database_session.execute(KeyspaceDefinition.geopoints_type)
			database_session.execute(KeyspaceDefinition.unprocessed_geopoints_table)
			database_session.execute(KeyspaceDefinition.processed_geopoints_table)
		end
	end
end
