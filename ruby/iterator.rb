require 'pry'

class Account
  attr_accessor :name, :balance

  def initialize
    @name = name
    @balance = balance
  end


  def <=> (other)
    binding.pry
    balance <=> other.balance
  end
end

class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block)
    binding.pry
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end



account1 = Account.new
account1.balance = 3000

account2 = Account.new
account2.balance = 1000


account3 = Account.new
account3.balance = 10000

portfolio = Portfolio.new
portfolio.add_account(account1)
portfolio.add_account(account2)
portfolio.add_account(account3)


puts portfolio.any? {|account| account.balance > 20000 }
# puts portfolio.all? {|account| account.balance >= 10}
