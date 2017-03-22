#!/usr/bin/env ruby

require_relative 'finder'
require_relative 'loader'

require 'optparse'

options = {}
optparser = OptionParser.new do |opts|
  opts.banner = 'Usage: bundle exec ./script.rb OPTIONS'

  options[:url] = 'http://chistoprudov.livejournal.com/196035.html'
  opts.on('-u', '--url=URL', "URL to be parsed. Default to #{options[:url]}") do |url|
    options[:url] = url
  end

  opts.on('-o', '--output DIR', 'Output directory for images') do |dir|
    options[:dir] = dir
  end
end

begin
  optparser.parse!
  raise OptionParser::MissingArgument if [:url, :dir].any? { |key| options[key].nil? }
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts optparser
  exit
end

module Ex1
  class Script
    def initialize(args)
      @url = args[:url]
      @dir = args[:dir]
    end

    def call
      loader.call
    end

    private

    attr_reader :url, :dir

    def finder
      @finder ||= Finder.new(url)
    end

    def loader
      @loader ||= Loader.new(finder.call, dir)
    end
  end
end

script = Ex1::Script.new(options)
script.call
