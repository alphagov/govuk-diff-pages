module Govuk
  module Diff
    module Pages
      module HtmlDiff
        class Runner
          def self.results_dir
            File.join(Govuk::Diff::Pages.results_dir, "html")
          end

          def self.assets_dir
            File.expand_path("../assets", __FILE__)
          end

          def initialize(list_of_pages_uri:)
            @pages = list_of_pages_uri
            @differ = Differ.new
          end

          def run
            diff_pages
            create_gallery
          end

        private

          def diff_pages
            @pages.each do |page|
              @differ.diff(page)
            end
          end

          def create_gallery
            gallery_template = File.read(File.join(self.class.assets_dir, "gallery_template.erb"))
            @result_hash = @differ.differing_pages

            FileUtils.mkdir_p(self.class.results_dir)
            renderer = ERB.new(gallery_template)
            File.open("#{self.class.results_dir}/gallery.html", "w") do |fp|
              fp.puts renderer.result(binding)
            end

            display_browser_message
          end

          def display_browser_message
            Kernel.puts "View the gallery of HTML diffs in your browser:"
            Kernel.puts "\tfile://#{self.class.results_dir}/gallery.html"
          end
        end
      end
    end
  end
end
