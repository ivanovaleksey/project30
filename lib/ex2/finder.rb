require 'logger'

$logger ||= Logger.new(nil)

class Finder
  attr_reader :k, :array, :find, :missing, :iterations

  def initialize(k, array, find = 2)
    @k = k
    @array = array
    @find  = find
    @missing = []
    @iterations = 0
  end

  def call
    # check at the ends first
    to_find = 2
    offset  = 0
    unless array[0] == 1
      to_find -= 1
      offset = 1
      @missing << 1
    end
    unless array[-1] == k
      to_find -= 1
      @missing << k
    end
    spawn_coroutine(0, array.size - 1, to_find, offset)
    missing.sort
  end

  private

  def spawn_coroutine(left, right, to_find, offset = 0)
    @iterations += 1
    middle = left + (right - left) / 2

    $logger.debug "left: #{left}, right: #{right}, middle: #{middle} | left_val: #{array[left]}, right_val: #{array[right]}, middle_val: #{array[middle]}, to_find: #{to_find}, offset: #{offset}"
    $logger.debug array[left..right]

    left_skips  = 0
    right_skips = 0

    # check adjacent elements
    middle_val = array[middle]

    assert_left_val = middle_val - 1
    if middle_val > 1 && array[middle - 1] != assert_left_val
      # to_find -= 1
      left_skips +=1
      @missing |= [assert_left_val]
    end

    assert_right_val = middle_val + 1
    if middle_val < k && array[middle + 1] != assert_right_val
      # to_find -= 1
      right_skips += 1
      @missing |= [assert_right_val]
    end

    # to_find -= missing.size
    $logger.debug "To find: #{to_find}"
    $logger.debug "Missing elements are: #{missing}"

    $logger.debug "Left skips: #{left_skips}, right skips: #{right_skips}"

    # check that element is at the right place
    # if skips_count = 2 all skips are on LHS
    # if skips_count = 1 one skip is on LHR and one is on RHS
    # if skips_count = 0 all skips are on RHS
    skips_count = middle_val - (middle + 1)
    skips_count -= offset
    $logger.debug "Skip count: #{skips_count}"

    $logger.debug '=' * 20
    $logger.debug ''

    return if to_find.zero?
    return if missing.size == 2

    case skips_count
    when 2
      lhs_to_find = to_find - left_skips
      spawn_coroutine(left, middle - 1, lhs_to_find, offset) if lhs_to_find.positive?
    when 1
      # TODO: should check if we already find left/right skip?
      # to_find -= 1
      lhs_to_find = [1, to_find - left_skips].min
      # lhs_to_find = to_find - left_skips
      spawn_coroutine(left, middle - 1, lhs_to_find, offset) if lhs_to_find.positive?

      # extract additional 1 since we just have spawned LHS coroutine
      to_find -= 1
      rhs_to_find = to_find - right_skips
      spawn_coroutine(middle + 1, right, rhs_to_find, 1) if rhs_to_find.positive?
    when 0
      # rhs_to_find = [to_find, 2 - right_skips].min
      rhs_to_find = to_find - right_skips
      offset = right_skips.positive? ? 1 : offset
      spawn_coroutine(middle + 1, right, rhs_to_find, offset) if rhs_to_find.positive?
    end
  end
end
