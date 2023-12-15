# frozen_string_literal: true

Dir[File.join(__dir__, "aoc_rb", "**", "*.rb")].each { |file| require file }

module AocRb
  class Error < StandardError; end
end
