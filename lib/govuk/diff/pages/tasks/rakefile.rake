require "govuk/diff/pages"

namespace :diff do
  desc 'produce visual diffs - set env var `URI` with location of a yaml file containing paths to diff'
  task visual: ['config:pre_flight_check'] do
    yaml_uri = ENV.fetch("URI")
    Govuk::Diff::Pages::VisualDiff::Runner.new(list_of_pages_uri: yaml_uri).run
  end

  desc 'produce html diffs - set env var `URI` with location of a yaml file containing paths to diff'
  task :html do
    yaml_uri = ENV.fetch("URI")
    Govuk::Diff::Pages::HtmlDiff::Runner.new(list_of_pages_uri: yaml_uri).run
  end

  desc 'produce text diffs'
  task :text do
    if ARGV.tap(&:shift).empty?
      abort "You must provide one or more YAML files containing the pages to diff"
    end

    left  = ENV.fetch("LEFT", "www-origin.staging.publishing.service.gov.uk")
    right = ENV.fetch("RIGHT", "www-origin.publishing.service.gov.uk")

    require 'yaml'

    ARGV.each do |file|
      Govuk::Diff::Pages::TextDiff::Runner.new(
        pages: YAML.load_file(file),
        left_domain: left,
        right_domain: right
      ).run
    end
  end

  desc "clears the results directory"
  task :clear_results do
    puts "---> Clearing results directory"
    require 'fileutils'
    FileUtils.remove_dir Govuk::Diff::Pages.results_dir
  end
end

namespace :config do
  desc "Checks that dependencies are in place"
  task :pre_flight_check do
    puts "Checking required packages installed."
    dependencies_present = true
    { imagemagick: 'convert', phantomjs: 'phantomjs' }.each do |package, binary|
      print "#{package}..... "
      result = %x[ which #{binary} ]
      if result.empty?
        puts "Not found"
        dependencies_present = false
      else
        puts "OK"
      end
    end
    unless dependencies_present
      abort("ERROR: A required dependency is not installed")
    end
  end
end
