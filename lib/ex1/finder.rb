require 'nokogiri'
require 'open-uri'

module Ex1
  class Finder
    def initialize(url)
      @url = url
    end

    def call
      Nokogiri::HTML(html).xpath('//img/@src')
                          .map(&:value)
                          .uniq
                          .grep(/\.(gif|jpe?g|tiff|png)/)
    end

    private

    attr_reader :url

    def html
      open(url)
    end
  end
end
