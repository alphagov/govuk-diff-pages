require "govuk/diff/pages/version"

module Govuk
  module Diff
    module Pages
      autoload :AppConfig, 'govuk/diff/pages/app_config'
      autoload :FormatSearcher, 'govuk/diff/pages/format_searcher'
      autoload :LinkChecker, 'govuk/diff/pages/link_checker'
      autoload :PageIndexer, 'govuk/diff/pages/page_indexer'
      autoload :PageSearcher, 'govuk/diff/pages/page_searcher'
      autoload :UrlChecker, 'govuk/diff/pages/url_checker'

      autoload :HtmlDiff, 'govuk/diff/pages/html_diff'
      autoload :TextDiff, 'govuk/diff/pages/text_diff'
      autoload :VisualDiff, 'govuk/diff/pages/visual_diff'

      def self.root_dir
        File.dirname __dir__
      end

      def self.shots_dir
        File.expand_path(root_dir + "/../../shots")
      end

      def self.govuk_pages_file
        config_file 'govuk_pages.yml'
      end

      def self.wraith_config_template
        config_file 'wraith.yaml'
      end

      def self.settings_file
        config_file 'settings.yml'
      end

      def self.config_file(filename)
        File.expand_path(root_dir + "/../../config/#{filename}")
      end
    end
  end
end
