#!/usr/bin/env ruby

require 'logger'
require_relative 'finder'
require_relative 'generator'

$logger = Logger.new(STDOUT)
$logger.level = Logger::INFO
$logger.formatter = proc do |severity, datetime, progname, msg|
  [severity, msg, "\n"].join(' ')
end

module Ex2
  class Script
    def call
      k = 15_000
      gen = Generator.new(k)
      arr = gen.call
      $logger.info "Missing numbers are: #{gen.missing_numbers}"

      finder = Finder.new(k, arr)
      finder.call

      $logger.info "Found missing numbers are: #{finder.missing}"
      $logger.info "#{finder.iterations} iterations made"
    end

    def total_call
      10_000.times do
        k = 15_000
        gen = Generator.new(k)
        arr = gen.call
        next if gen.missing_numbers.uniq.size == 1

        finder = Finder.new(k, arr)
        res = finder.call
        unless res == gen.missing_numbers
          $logger.error("Found numbers are not equal to generated ones: #{res} vs. #{gen.missing_numbers}")
        end
      end
    end
  end
end

Ex2::Script.new.call
