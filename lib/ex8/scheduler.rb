require_relative 'calculator'
require_relative 'rounder'

module Ex8
  class Scheduler
    def initialize(args)
      @args     = args
      @days     = @args[:days]
      @amount   = @args[:amount]
      @payments = @args[:payments]
    end

    def total_amount
      list.reduce(0) { |acc, elem| acc + elem[:amount] }
    end

    def list
      @list ||= begin
        schedule = 1.upto(payments - 1).reduce([]) do |acc, m|
          add_payment(acc, m * payment_period, Rounder.up_if_odd(raw_payment_amount))
        end
        add_last_payment(schedule)
        schedule
      end
    end

    private

    attr_reader :days, :amount, :payments

    def add_last_payment(schedule)
      current_amount = schedule.reduce(0) { |acc, elem| acc + elem[:amount] }
      delta = Rounder.up_if_odd(raw_total_amount) - current_amount
      add_payment(schedule, days, delta)
    end

    def add_payment(schedule, day, amount)
      schedule << { day: day, amount: amount }
    end

    def calc
      @calc ||= Calculator.new(@args)
    end

    def raw_total_amount
      @raw_total_amount ||= raw_payment_amount * payments
    end

    def raw_payment_amount
      @raw_payment_amount ||= calc.payment_amount
    end

    def payment_period
      @payment_period ||= calc.payment_period.to_i
    end
  end
end
