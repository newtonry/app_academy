=begin
# Three ways for input
- from gets
from option to rpn.rb from terminal
- from file called from terminal
=end
def rpn(rpn_string)
  stack = []
  inputs = rpn_string.split(" ")
  inputs.each do |input|
    if input =~ /\d+/
      stack.push(input.to_i)
    else
      stack.push((stack.pop).send input.to_sym, stack.pop)
    end
  end
  stack[0]
end

def get_user_input
    puts "Input calculations one character at a time. To finish, input <end>"
    user_input_string = ""
    loop do
      char = gets.chomp
      break if char == "end"
      user_input_string << char + " "
    end
    user_input_string.strip
end

if ARGV[0]
  input_string = File.read(ARGV[0])
  p rpn(input_string)
else
  __FILE__ == $PROGRAM_NAME
    input_string = get_user_input()
    p rpn(input_string)
end
