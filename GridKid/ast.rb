require_relative 'lexer.rb'
require_relative 'parser.rb'
require_relative 'evaluator.rb'
require_relative 'serializer.rb'
require_relative 'primitives.rb'
require_relative 'operations.rb'

def evaluate_expression(expression, evaluator, runtime)
    lexer = Lexer.new(expression)
    tokens = lexer.tokenize
    parser = Parser.new(tokens)
    ast = parser.parse


    result = traverse_ast(ast, evaluator, runtime)

    result
end

def traverse_ast(node, evaluator, runtime)
    return node if node.is_a?(Numeric)
    
    case node[:type]
    when :CellRValue, :boolPrim, :string, :max, :min, :mean, :sum, :CellLValue, :plus, :hyphen, :asterisk, :slash, :modulo, :exponent, :bitwise_not, :bitwise_or, :ampersand, :left_shift, :right_shift, :logical_not, :logical_and, :logical_or, :double_equals, :not_equals, :less_than, :less_than_equal, :greater_than, :greater_than_equal
      result = node[:value].traverse(evaluator, runtime)
    else
      raise "Unknown node type: #{node[:type]}"
    end
    
    result
  end
