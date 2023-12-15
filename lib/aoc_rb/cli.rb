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

      bin_dir = File.join(project_dir, "bin")
      bin_path = File.join(bin_dir, "aoc")
      bin_template = File.join(__dir__, "../../templates/bin/aoc")
      FileUtils.mkdir_p bin_dir
      File.write(bin_path, File.read(bin_template))

      shared_dir = File.join(project_dir, "challenges", "shared")
      solution_path = File.join(shared_dir, "solution.rb")
      solution_template = File.join(__dir__, "../../templates/solution_base.rb")
      FileUtils.mkdir_p shared_dir
      File.write(solution_path, File.read(solution_template))

      spec_dir = File.join(project_dir, "spec")
      spec_helper_path = File.join(spec_dir, "spec_helper.rb")
      spec_helper_template = File.join(__dir__, "../../templates/spec/spec_helper.rb")
      FileUtils.mkdir_p spec_dir
      File.write(spec_helper_path, File.read(spec_helper_template))

      env_template_path = File.join(project_dir, ".env-template")
      env_template = File.join(__dir__, "../../templates/.env-template")
      File.write(env_template_path, File.read(env_template))

      gemfile_dst = File.join(project_dir, "Gemfile")
      gemfile_src = File.join(__dir__, "../../templates/Gemfile")
      File.write(gemfile_dst, File.read(gemfile_src))
    end

    desc "version", "prints the current installed version of AocRb"

    def version
      puts "AocRb version #{AocRb::VERSION}"
    end
  end
end
