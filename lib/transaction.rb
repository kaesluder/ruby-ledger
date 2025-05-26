require_relative 'split'
require 'date'

class Transaction
  attr_accessor :date, :description, :splits

  def initialize(date, description, splits)
    raise ArgumentError, 'Date is invalid' if date.nil? || !date.is_a?(Date)
    raise ArgumentError, 'Description cannot be empty' if description.nil? || description.strip.empty?
    raise ArgumentError, 'At least two splits must be provided' if splits.nil? || splits.length < 2
    raise ArgumentError, 'Splits must sum to zero' unless zero_sum_splits?(splits)

    @date = date
    @description = description
    @splits = splits
  end

  def zero_sum_splits?(splits)
    sum_debits = 0
    sum_credits = 0

    splits.each do |split|
      sum_debits += split.debit
      sum_credits += split.credit
    end
    (sum_debits - sum_credits).abs < 0.0001
  end
end
