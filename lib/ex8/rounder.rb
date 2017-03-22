module Ex8
  module Rounder
    PLACES = 1

    module_function

    def down(amount)
      (amount - amount % (10 ** PLACES)).to_i
    end

    def up_if_odd(amount)
      return amount.to_i if amount % 10 == 0
      up(amount)
    end

    def up(amount)
      ((amount.to_i + 10 ** PLACES) / (10 ** PLACES)) * (10 ** PLACES)
    end
  end
end
