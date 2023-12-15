# frozen_string_literal: true

require "fileutils"
require "aoc_rb/app_loader"
AocRb::AppLoader.exec_app

require "thor"

module AocRb
  class Cli < Thor
    def self.exit_on_failure?
      false
    end

    desc "new NAME", "Creates a new AoC project with the given name"

    def new(name)
      project_dir = File.join(Dir.getwd, name)
      if File.exist?(project_dir)
        puts "ERROR: #{project_dir} already exists!"
        exit(-1)
      end

      files = {
        "bin/aoc" => "bin/aoc",
        "solution_base.rb" => "challenges/shared/solution.rb",
        "spec/spec_helper.rb" => "spec/spec_helper.rb",
        ".env-template" => ".env-template",
        "Gemfile" => "Gemfile"
      }

      files.each do |source, target|
        source_file = File.join(__dir__, *"../../templates/#{source}".split("/"))
        target_file = File.join(project_dir, *target.split("/"))
        FileUtils.mkdir_p(File.dirname(target_file))
        File.write(target_file, File.read(source_file))
      end
    end

    desc "version", "prints the current installed version of AocRb"

    def version
      puts "AocRb version #{AocRb::VERSION}"
    end
  end
end
