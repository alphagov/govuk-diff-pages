$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'govuk/diff/pages'
require 'pry'

module FixtureHelper
  def self.load_paths_from(filename)
    YAML.load open(File.join(File.dirname(__dir__), "spec", "fixtures", filename))
  end
end
