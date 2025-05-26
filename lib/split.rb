class TransactionSplit
  attr_accessor :account, :credit, :debit

  def initialize(account, credit, debit)
    @account = account
    @credit = credit
    @debit = debit
  end
end
