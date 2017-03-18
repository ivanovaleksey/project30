class Generator
  attr_reader :k, :missing_count

  def initialize(k, missing_count = 2)
    @k = k
    @missing_count = missing_count
  end

  def call
    missing_indexes = Array.new(missing_count) { rand(k) }.sort
    # puts "Missing indexes are: #{missing_indexes}"
    puts "Missing numbers are: #{missing_indexes.map { |index| index + 1 }}"
    1.upto(k).to_a.tap do |arr|
      missing_indexes.each_with_index { |missing_index, index| arr.delete_at(missing_index - index) }
    end
  end
end

class Finder
  attr_reader :array, :find, :missing

  def initialize(array, find = 2)
    @array = array
    @find  = find
    @missing = []
  end

  def call
    # TODO: remove hardcoded 15
    process(0, array.size - 1, 15)
  end

  private

  def process(start_index, end_index, assume_size)
    size = end_index - start_index + 1
    # TODO: seems to be wrong
    return if size == 1

    middle = start_index + assume_size / 2 - 1

    puts "#{start_index}, #{end_index}, #{assume_size}, #{middle}"
    p array[start_index..end_index]

    # split array in 2 parts

    part_1_start = start_index
    part_1_end   = middle + assume_size % 2

    puts "Part 1: [#{part_1_start}..#{part_1_end}] - #{array[part_1_start..part_1_end]}"

    part_2_start = part_1_end + 1
    part_2_end   = end_index

    puts "Part 2: [#{part_2_start}..#{part_2_end}] - #{array[part_2_start..part_2_end]}"

    assume_size_1 = part_2_start
    assume_size_2 = assume_size - part_2_start

    missing_count_part_1 = (array[part_1_start] - (part_1_start + 1)) + (array[part_1_end] - (part_1_end + 1))
    missing_count_part_2 = find - missing_count_part_1

    puts "Missing count part 1: #{missing_count_part_1}"
    puts "Missing count part 2: #{missing_count_part_2}"

    puts '=' * 20
    puts

    process(part_1_start, part_1_end, assume_size_1) if missing_count_part_1.positive?
    process(part_2_start, part_2_end, assume_size_2) if missing_count_part_2.positive?
  end

  # Check if particular array slice has missing elements
  def full?(start_index, end_index)
    array[start_index] == start_index + 1 && array[end_index] == end_index + 1
  end
end

@gen = Generator.new(15)
# @finder = Finder.new(@gen.call)
arr = [1, 2, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15]
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14]
@finder = Finder.new(arr)
@finder.call
