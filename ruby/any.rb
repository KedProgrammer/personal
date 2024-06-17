require 'pry'
module Enumerable
  def any?
    puts 'holi'
  end
end

class Array
  def any2
    i = 0

    while i < self.length
      return true if yield(self[i])
      i += 1
    end

    return false
  end
end

puts [10].any2 { |element| element > 1 }