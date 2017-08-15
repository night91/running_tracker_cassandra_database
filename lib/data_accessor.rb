require_relative 'types/geopoint'

module RunningTrackerCassandraDatabase
	class DataAccessor
		attr_reader :session

		def initialize(session)
			@session = session
		end

		def add_geopoint(training_session_id, longitude, latitude)
			statement = @session.prepare(
				'INSERT INTO unprocessed_geopoints (training_session_id, id, datetime, location) VALUES (?, now(), ? ,{ longitude: ?, latitude: ? })'
			)
			@session.execute(statement, arguments: [training_session_id, Time.now, longitude, latitude])
		end

		def delete_proccesed_geopoints(processed_geopoints_list)
			statement = @session.prepare('DELETE FROM unprocessed_geopoints WHERE training_session_id = ? and id = ?')
			batch = @session.batch do |batch|
				processed_geopoints_list.each do |geopoint|
					batch.add(statement,
					 arguments: [
					 	geopoint['training_session_id'],
					 	geopoint['id']
					 ]
					)
				end
			end
			session.execute(batch)

		end

		def count_unprocessed_geopoints(training_session_id)
			statement = @session.prepare('SELECT count(*) FROM unprocessed_geopoints WHERE training_session_id = ?')
			result = @session.execute(statement, arguments: [training_session_id])
			result.rows.first['count']
		end

		def fetch_geopoints_to_process(training_session_id)
			statement = @session.prepare('SELECT * FROM unprocessed_geopoints WHERE training_session_id = ?')
			result = @session.execute(statement, arguments: [training_session_id])
			result.rows
		end

		def copy_processed_geopoints(processed_geopoints_list)
			statement = @session.prepare('INSERT INTO processed_geopoints (training_session_id, id, datetime, location) VALUES (?, ?, ?, { longitude: ?, latitude: ? })')
			batch = @session.batch do |batch|
				processed_geopoints_list.each do |geopoint|
					batch.add(statement,
					 arguments: [
					 	geopoint['training_session_id'],
					 	geopoint['id'],
					 	geopoint['datetime'],
					 	geopoint['location'].longitude,
					 	geopoint['location'].latitude
					 ]
					)
				end
			end
			session.execute(batch)
		end
	end
end