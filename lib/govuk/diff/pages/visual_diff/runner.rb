module Govuk
  module Diff
    module Pages
      module VisualDiff
        class Runner
          def initialize(paths:, kernel: Kernel)
            @paths = paths
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
