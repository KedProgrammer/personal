

def factorial(number)
  result = 1
  number.times do |n|
    result = result * (n + 1)
  end

  puts result
end




def fibonacci(number1, number2,  limit = 100)
  new_number = number1 + number2
  puts new_number
  return if new_number > limit

  fibonacci(number2, new_number, 20000)
end

fibonacci(0,1)