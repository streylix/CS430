require_relative "lexer.rb"
require_relative "parser.rb"
require_relative "token.rb"
require_relative "ast.rb"

def testLexer(string, type)
  puts "---===LEXING #{type}===---"
  lexer = Lexer.new(string)
  tokens = lexer.tokenize

  tokens.each do |token|
      puts "#{token.type}: '#{token.text}'"
  end

  begin
    parser = Parser.new(tokens)
    ast = parser.parse
    puts "#{type} is working!"
  rescue => e
      puts "Not there yet. Error: #{e.message}"
  end
  puts "---===##########===---\n\n"
end

def testParsing(string, type)
  puts "---===PARSING #{type}===---"
  lexer = Lexer.new(string)
  tokens = lexer.tokenize
  parser = Parser.new(tokens)

  begin
    ast = parser.parse
    puts ast
    puts "#{type} parsing is successful!"
  rescue => e
    puts "Parsing failed for #{type}. Error: #{e.message}"
  end

  puts "---===##########===---\n\n"
end

runtime = Runtime.new
evaluator = Evaluator.new

runtime.grid.set_cell([0, 0], IntPrimitive.new(4))
runtime.grid.set_cell([1, 1], IntPrimitive.new(16))
runtime.grid.set_cell([2, 4], IntPrimitive.new(8))

puts "\n\n-----======Required Tests======-----"
puts "1. \"(5 + 2) * 3.5 % 4\": #{evaluate_expression("(5 + 2) * 3.5 % 4", evaluator, runtime).value}"
puts "2. \"#[0, 0] + 3\": #{evaluate_expression("#[0, 0] + 3", evaluator, runtime).value}"
puts "3. \"#[1 - 1, 0] < #[1 * 1, 1]\": #{evaluate_expression("#[1 - 1, 0] < #[1 * 1, 1]", evaluator, runtime).value}"
puts "4. \"(5 > 3) && !(2 > 8)\": #{evaluate_expression("(5 > 3) && !(2 > 8)", evaluator, runtime).value}"
puts "5. \"1 + sum([0, 0], [2, 1])\": #{evaluate_expression("1 + sum([0, 0], [2, 1])", evaluator, runtime).value}"
puts "6. \"float(10) / 4.0\": #{evaluate_expression("float(10) / 4.0", evaluator, runtime).value}"
puts "-----======##############======-----\n\n"
puts "-----======Personal Tests======-----"
puts "1. \"2 + 2.5\": #{evaluate_expression("2 + 2.5", evaluator, runtime).value}"
puts "2. \"12 > 2 && 1 + 1 == 2\": #{evaluate_expression("12 > 2 && 1 + 1 == 2", evaluator, runtime).value}"
puts "3. \"mean([78, 82], [81, 23])\": #{evaluate_expression("mean([78, 82], [81, 23])", evaluator, runtime).value}"
puts "4. \"#[1 + 1, 4] << 3\": #{evaluate_expression("#[1 + 1, 4] << 3", evaluator, runtime).value} (DOESNT WORK)"
puts "5. \"min([6*6, 5*7], [35 - 1, 12 * 3 - 5])\": #{evaluate_expression("min([6*6, 5*7], [35 - 1, 12 * 3 - 5])", evaluator, runtime).value}"
puts "6. \" \"I am a string sequence\" \": #{evaluate_expression("\"I am a string sequence\"", evaluator, runtime).value.text}"
puts "7. \" \"12 + 3\" \": #{evaluate_expression("\"12 + 3\"", evaluator, runtime).value.text}"
puts "-----======##############======-----\n\n"
# testParsing("#[0, 0] + 3", "Rvalue lookup and shift")
# testLexer("#[1 - 1, 0] < #[1 * 1, 1]", "RValue lookup and comparison")
# testParsing("#[1 - 1, 0] < #[1 * 1, 1]", "RValue lookup and comparison")
# testLexer("(5 > 3) && !(2 > 8)", "Logic and comparison")
# testParsing("(5 > 3) && !(2 > 8)", "Logic and comparison")
# testLexer("1 + sum([0, 0], [2, 1])", "Sum")
# testParsing("1 + sum([0, 0], [2, 1])", "Sum")
#testLexer("float(10) / 4.0", "Casting")
# testParsing("float(10) / 4.0", "Casting")

# puts "\n\n--==Personal Tests==--\n\n"
# testLexer("\"This\" \"is\" \"a\" \"sequence\" \"of\" \"words!\"", "Strings")
# testParsing("\"This\" \"is\" \"a\" \"sequence\" \"of\" \"words!\"", "Strings")
# testLexer("'c' 'h' 'a' + 'r'", "chars")
# testParsing("'c' 'h' 'a' + 'r'", "Characters")

