module Govuk
  module Diff
    module Pages
      module VisualDiff
        class Runner
          def initialize(list_of_pages_uri:, kernel: Kernel)
            @paths = list_of_pages_uri
            @kernel = kernel
          end

          def run
            wraith_config = WraithConfig.new(paths: @paths)
            wraith_config.write

            cmd = "wraith capture #{wraith_config.location}"
            puts "---> Creating Visual Diffs"
            puts "running: #{cmd}"
            @kernel.system cmd

            wraith_config.delete
          end
        end
      end
    end
  end
end
