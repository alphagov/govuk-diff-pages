require 'yaml'
require 'tempfile'
require 'open-uri'

module Govuk
  module Diff
    module Pages
      module VisualDiff
        class Runner
          def initialize(list_of_pages_uri:)
            @list_of_pages_uri = list_of_pages_uri
          end

          def run
            paths = YAML.load open(@list_of_pages_uri)
            wraith_config = WraithConfig.new(paths: paths)
            wraith_config.write

            Kernel.puts "---> Creating Visual Diffs"
            cmd = "wraith capture #{wraith_config.location}"
            Kernel.puts "running: #{cmd}"
            Kernel.system cmd

            wraith_config.delete
          end
        end
      end
    end
  end
end
