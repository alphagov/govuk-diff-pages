require 'nokogiri'

module TextDiff
  class Formatter
    def call(html)
      Nokogiri::HTML(html).xpath("//text()").text
    end
  end
end
