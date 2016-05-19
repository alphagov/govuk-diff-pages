require 'govuk/diff/pages'

namespace :diff do
  desc 'produce visual diffs'
  task visual: ['config:pre_flight_check'] do
    yaml_uri = ENV.fetch("URI")
    Govuk::Diff::Pages::VisualDiff::Runner.new(list_of_pages_uri: yaml_uri).run
  end

  desc 'produce html diffs'
  task :html do
    Govuk::Diff::Pages::HtmlDiff::Runner.new.run
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

  desc "clears the screen shots directory"
  task :clear_shots do
    puts "---> Clearing shots directory"
    require 'fileutils'
    config = Govuk::Diff::Pages::AppConfig.new
    [config.wraith.directory, config.html_diff.directory].each do |directory|
      shots_dir = "#{Govuk::Diff::Pages.root_dir}/#{directory}"
      FileUtils.remove_dir shots_dir
    end
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

  desc 'update config files with list of pages to diff'
  task :update_page_list do
    puts "---> Updating page list"
    Govuk::Diff::Pages::PageIndexer.new.run
  end

  desc 'checks all URLs are accessible'
  task :check_urls do
    Govuk::Diff::Pages::LinkChecker.new.run
  end
end

