require_relative '../lib/split'
require_relative '../lib/transaction'
require 'date'

RSpec.describe Transaction do
  context 'happy path tests' do
    let(:split1) { TransactionSplit.new('Asset', 5.0, 0) }
    let(:split2) { TransactionSplit.new('Liability', 0, 5.0) }
    let(:date) { Date.new(2025, 1, 15) }
    let(:description) { 'New transaction' }

    it 'validates transaction with good splits' do
      transaction = Transaction.new(date, description, [split1, split2])
      expect(transaction.date).to eq(date)
    end
  end

  context 'error raising tests' do
    let(:split1) { TransactionSplit.new('Asset', 5.0, 0) }
    let(:split2) { TransactionSplit.new('Liability', 0, 1.0) }
    let(:date) { Date.new(2025, 1, 15) }
    let(:description) { 'New transaction' }

    it 'raises an error if date is nil' do
      date = nil
      expect { Transaction.new(date, description, [split1, split2]) }.to raise_error(ArgumentError, 'Date is invalid')
    end
    it 'raises an error if description is nil' do
      description = nil
      expect do
        Transaction.new(date, description, [split1, split2])
      end.to raise_error(ArgumentError, 'Description cannot be empty')
    end
    it 'raises an error if transaction is unbalanced' do
      expect do
        Transaction.new(date, description, [split1, split2])
      end.to raise_error(ArgumentError, 'Splits must sum to zero')
    end
    it 'raises an error if splits are empty ' do
      expect do
        Transaction.new(date, description, [])
      end.to raise_error(ArgumentError, 'At least two splits must be provided')
    end
  end
end
