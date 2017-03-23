require 'fileutils'
require 'open-uri'
require 'pathname'

module Ex1
  class Loader
    PER_FOLDER  = 10
    CONCURRENCY = 5

    def initialize(links, dir)
      @links = links
      @base_dir = Pathname.new(dir)
    end

    def call
      links.each_slice(PER_FOLDER).each_with_index do |folder_slice, index|
        dir = dir_name(index + 1)
        prepare_dir(dir)

        folder_slice.each_slice(CONCURRENCY) do |slice|
          threads = slice.map do |link|
            Thread.new { store_image(link, dir) }
          end

          threads.each(&:join)
        end
      end
    end

    private

    attr_reader :links, :base_dir

    def prepare_dir(dir_name)
      FileUtils.mkdir_p(dir_name) unless Dir.exist?(dir_name)
    end

    def dir_name(index)
      base_dir.join(index.to_s)
    end

    def store_image(link, dir)
      file = file_path(link, dir)
      File.open(file, 'w') { |img| img << open(link).read }
    end

    def file_path(link, dir)
      dir.join(file_name(link))
    end

    def file_name(link)
      /^http[s]?:\/\/(?<host>[^:\/\s]+)\/(?<name>.*)$/ =~ link
      host = host.tr('.', '-')
      name = name.gsub('/', '-')
      [host, name].join('-')
    end
  end
end
