module Ex8
  class Calculator
    def initialize(args)
      @days     = args[:days]
      @amount   = args[:amount]
      @percent  = args[:percent] / 100.0
      @payments = args[:payments]
    end

    def call
      payment_amount
    end

    def payment_amount
      numerator / denominator
    end

    def payment_period
      days.to_f / payments
    end

    private

    attr_reader :amount, :percent, :days, :payments

    def numerator
      amount * ((1 + percent) ** days)
    end

    def denominator
      eval(denominator_formula)
    end

    # 1                          | when payments = 1
    # (1 + p)^n + 1              | when payments = 2
    # (1 + p)^n + (1 + p)^2n + 1 | when payments = 3
    # so on and so forth
    def denominator_formula
      1.upto(payments - 1).map { |m| "(1 + percent) ** (#{m} * payment_period)" }
                          .push(1)
                          .join(' + ')
    end
  end
end
