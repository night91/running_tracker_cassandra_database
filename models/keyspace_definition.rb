module RunningTrackerCassandraDatabase
  module KeyspaceDefinition
    class << self
      KEYSPACE_NAME = 'running_tracker'

      def keyspace_name
        KEYSPACE_NAME
      end

      def keyspace_definition
        keyspace_definition = <<-KEYSPACE_CQL
          CREATE KEYSPACE running_tracker
          WITH replication = {
            'class': 'SimpleStrategy',
            'replication_factor': 3
          }
        KEYSPACE_CQL
      end

      def geopoints_type
        type_definition = <<-TYPE_CQL
          CREATE TYPE geopoint (
              latitude double,
              longitude double,
          )
          TYPE_CQL
      end

      def unprocessed_geopoints_table
        table_definition = <<-TABLE_CQL
          CREATE TABLE unprocessed_geopoints (
            training_session_id text,
            id timeuuid,
            datetime timestamp,
            location frozen<geopoint>,
            PRIMARY KEY (training_session_id, id)
          ) WITH CLUSTERING ORDER BY (id ASC)
        TABLE_CQL
      end

      def processed_geopoints_table
        table_definition = <<-TABLE_CQL
          CREATE TABLE processed_geopoints (
            training_session_id text,
            id timeuuid,
            datetime timestamp,
            location frozen<geopoint>,
            PRIMARY KEY (training_session_id, id)
          ) WITH CLUSTERING ORDER BY (id ASC)
        TABLE_CQL
      end
    end
  end
end
