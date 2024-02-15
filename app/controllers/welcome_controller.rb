class WelcomeController < ApplicationController
  def index
    _, question = params[:q].split(": ", 2)
    case question
    when /what is the english scrabble score of (\w+)/
      word = $1
      score_table = {
        'a' => 1, 'b' => 3, 'c' => 3, 'd' => 2, 'e' => 1,
        'f' => 4, 'g' => 2, 'h' => 4, 'i' => 1, 'j' => 8,
        'k' => 5, 'l' => 1, 'm' => 3, 'n' => 1, 'o' => 1,
        'p' => 3, 'q' => 10, 'r' => 1, 's' => 1, 't' => 1,
        'u' => 1, 'v' => 4, 'w' => 4, 'x' => 8, 'y' => 4,
        'z' => 10
      }
      @answer = word.downcase.chars.sum { |char| score_table[char] }
    when /which of the following is an anagram of "(\w+)":/
      word = $1
      anagrams = question.scan(/"(\w+)"/).flatten

      @answer = anagrams.find { |anagram| anagram.chars.sort == word.chars.sort }
    when /what is (\d+) multiplied by (\d+) plus (\d+)/
      puts "Asnwering  multiplied by  plus "
      @answer = $1.to_i * $2.to_i + $3.to_i
    when /what is (\d+) plus (\d+) multiplied by (\d+)/
      puts "Answering plus multiplied by"
      @answer = $1.to_i + $2.to_i * $3.to_i
    when /(\d+) plus (\d+)/
      puts "Asnwering a plus b"
      @answer = question.scan(/\d+/).to_a.map(&method(:Integer)).inject(&:+)
      # @answer = Integer($1) + Integer($2)
    when /(\d+) minus (\d+)/
      puts "Asnwering a minus b"
      @answer = question.scan(/\d+/).to_a.map(&method(:Integer)).inject(&:-)
    when /(\d+) multiplied by (\d+)/
      puts "Asnwering a multiplied by b"
      @answer = Integer($1) * Integer($2)
    when /is the largest/
      puts "Asnwering the largest"
      nums = question.scan(/\d+/).to_a.map(&method(:Integer))
      @answer = nums.max
    when /to the power of/
      puts "Asnwering the power of"
      nums = question.scan(/\d+/).to_a.map(&method(:Integer))
      @answer = nums[0] ** nums[1]
    when /square and a cube/
      puts "Asnwering the square/cube crap"
      nums = question.scan(/\d+/).to_a.map(&method(:Integer))
      @answer = nums.find { |n|
        check_root_type(n) == 'both'
      }
    when /primes/
      puts "Asnwering the primes"
      nums = question.scan(/\d+/).to_a.map(&method(:Integer))
      # @answer = nums.select { |n| (2..Math.sqrt(n)).none? { |d| n % d == 0 } }
      @answer = nums.select(&method(:prime?)).join(", ")
    when /what colour/
      @answer = case question
      when /banana/
        "yellow"
      when /grass/
        @answer = "green"
      when /sky/
        @answer = "blue"
      end
    when /which year was Theresa May first elected as the Prime Minister of Great Britain/
        @answer = "2016"
    when /which city is the Eiffel tower in/
        @answer = "Paris"
    when /what is the (\d+).*? number in the Fibonacci sequence/
      n = Integer($1)
      fib ||= (0..1000).each_with_object([0, 1]) { |_, obj| obj << obj[-2] + obj[-1] }
      @answer = fib[n]
    when "who played James Bond in the film Dr No"
      @answer = "Sean Connery"
    else
      @answer = nil
    end

    puts @answer
    render plain: @answer.to_s if @answer
  rescue Exception => e
    puts "ERRRRROOOOORRRR: #{e.inspect}"
    render nothing: true
  end

  def prime?(n)
    return false if n < 2
    return true if n == 2 || n == 3
    return false if n % 2 == 0 || n % 3 == 0

    i = 5
    w = 2

    while i * i <= n
      return false if n % i == 0
      i += w
      w = 6 - w
    end

    true
  end

  def check_root_type(n)
    square_root = Math.sqrt(n)
    cube_root = n ** (1/3.0)

    is_square = (square_root.round ** 2 == n)
    is_cube = (cube_root.round ** 3 == n)

    if is_square && is_cube
      'both' # n is both a perfect square and a perfect cube (e.g., 1, 64)
    elsif is_square
      'square' # n is a perfect square
    elsif is_cube
      'cube' # n is a perfect cube
    else
      'neither' # n is neither a perfect square nor a perfect cube
    end
  end
end
