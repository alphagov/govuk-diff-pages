$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'govuk/diff/pages'

module FixtureHelper
  def self.locate(filename)
    File.join(File.dirname(__dir__), "spec", "fixtures", filename)
  end
end
