require 'pry'

def to_numeral(str)
  num_conversion = {
    'zero' => 0,
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9,
    'ten' => 10
  }
  return nil unless num_conversion.key?(str)
  num_conversion[str]
end

def crunch_numbers(num2, operation, num1)
  case operation
  when 'plus'
    num1 + num2
  when 'minus'
    num1 - num2
  when 'times'
    num1 * num2
  when 'divided'
    num1.to_f / num2.to_f
  end
end

def return_processed_arr(raw_phrase)
  stack = []
  raw_phrase.split.each do |word|
    if to_numeral(word).nil?
      next if word == 'by'
      stack << word
    else
      stack << to_numeral(word)
    end
  end
  stack
end

def computer(phrase)
  stack = []
  ordered_operations = ['times', 'divided']
  units = return_processed_arr(phrase)
  units.each do |item|
    if item.class == Fixnum && ordered_operations.include?(stack.last)
      stack << crunch_numbers(item, stack.pop, stack.pop)
    else
      stack << item
    end
  end
  final_calc = []
  ops = ['plus', 'minus']
  stack.each do |item|
    if item.class == Fixnum && ops.include?(final_calc.last)
      final_calc << crunch_numbers(item, final_calc.pop, final_calc.pop)
    else
      final_calc << item
    end
  end
  final_calc << crunch_numbers(final_calc.pop, final_calc.pop, final_calc.pop) if final_calc.length == 3
  final_calc
end

p computer("two plus two")
p computer("seven minus six")
p computer("two plus two minus three")
p computer("three minus one plus five minus four plus six plus ten minus four")
p computer("eight times four plus six divided by two minus two")
p computer("one plus four times two minus two")
p computer("nine divided by three times six")
p computer("seven plus four divided by two")
p computer("seven times four plus one divided by three minus two")
p computer("one plus four times three divided by two minus two")
p computer("nine divided by three times six")
