require "net/http"
require "cgi"

addresses = [
  "https://stuff.ngrok-free.app",
  "https://nonsense.ngrok-free.app"
]

queries = [
  "what is -3 plus 7",
  "what can be calculated from #{(1..1024).sample} and 7 by adding them",
  "what is the capital of Germany",
  "how many people are in space",
  "what is the tallest mountain in the world",
  "who wrote the play 'Romeo and Juliet'",
  "what is the chemical symbol for water",
  "how long is the Great Wall of China",
  "what is the speed of light",
  "who was the first person to walk on the moon",
  "what is the largest ocean on Earth",
  "when was the Declaration of Independence signed",
  "what is the smallest planet in our solar system",
  "how many bones are in the human body",
  "what is the result of 15 multiplied by 6",
  "how much is 42 divided by 7",
  "what do you get when you subtract 20 from 100",
  "what is 8 to the power of 2",
  "if you split 180 into three equal parts, what is one part",
  "what is the square root of 81",
  "how many times does 5 go into 45",
  "what is 12 percent of 250",
  "if I have 30 apples and give away half, how many do I have left",
  "what is the sum of 17, 24, and 33"
]

loop do
  query = CGI.escape("#{SecureRandom.hex(8)}: #{queries.sample}")

  addresses.each do |address|
    puts "Sending request to #{address} with query: #{query}"
    Net::HTTP.get(URI("#{address}/?q=#{query}"))
  end

  sleep [1,2].sample
end
