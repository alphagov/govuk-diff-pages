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
      autoload :WraithConfigGenerator, 'govuk/diff/pages/wraith_config_generator'

      autoload :HtmlDiff, 'govuk/diff/pages/html_diff'
      autoload :TextDiff, 'govuk/diff/pages/text_diff'

      def self.root_dir
        File.dirname __dir__
      end

      def self.govuk_pages_file
        config_file 'govuk_pages.yml'
      end

      def self.wraith_config_file
        config_file 'wraith.yaml'
      end

      def self.settings_file
        config_file 'settings.yml'
      end

    private

      def self.config_file(filename)
        File.expand_path(root_dir + "/../../config/#{filename}")
      end
    end
  end
end
