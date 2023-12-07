# frozen_string_literal: true

Dir[File.join(__dir__, "..", "challenges", "shared", "**", "*.rb")].each do |file|
  require file
end

Dir[File.join(__dir__, "..", "challenges", "20*", "**", "*.rb")].each do |file|
  require file
end

RSpec.configure do |config|
  config.default_formatter = "doc"
  config.example_status_persistence_file_path = ".rspec_status"
  config.filter_run_when_matching :focus
end
