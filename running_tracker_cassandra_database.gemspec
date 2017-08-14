# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "running_tracker_cassandra_database/version"

Gem::Specification.new do |spec|
  spec.name          = "running_tracker_cassandra_database"
  spec.version       = RunningTrackerCassandraDatabase::VERSION
  spec.authors       = ["Eddy Roberto Morales Perez"]
  spec.email         = ["eddyr.morales@gmail.com"]

  spec.summary       = "Gem to handle the cassandra database"
  spec.description   = "Gem to handle the cassandra database"
  spec.homepage      = "https://github.com/night91/running_tracker_cassandra_database"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "cassandra-driver", "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "highline", "~> 1.7"
  spec.add_development_dependency "colorize", "~> 0.8"
end
