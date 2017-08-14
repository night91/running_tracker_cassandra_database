require "spec_helper"

RSpec.describe RunningTrackerCassandraDatabase do
  it "has a version number" do
    expect(RunningTrackerCassandraDatabase::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
