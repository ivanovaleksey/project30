module Ex2
  class Generator
    attr_reader :k, :missing_count

    def initialize(k, missing_count = 2)
      @k = k
      @missing_count = missing_count
    end

    def call
      1.upto(k).to_a.tap do |arr|
        missing_indexes.each_with_index { |missing_index, index| arr.delete_at(missing_index - index) }
      end
    end

    def missing_numbers
      @missing_indexes.map { |index| index + 1 }
    end

    private

    def missing_indexes
      @missing_indexes = Array.new(missing_count) { rand(k) }.sort
    end
  end
end
