require_relative "primitives"
require_relative "operations"

class Parser
    def initialize(tokens)
        @tokens = tokens
        @i = 0
    end

    def has(type)
        @i < @tokens.size && @tokens[@i].type == type
    end

    def previous
        @tokens[@i - 1]
    end

    def advance
        current = @tokens[@i]
        @i += 1 if @i < @tokens.size
        current
    end

    def needs_parsing?
        @i < @tokens.size
    end

    def parse
        expression
    end

    private

    def expression
        logical
    end

    def logical
        expr = relational

        while has(:logical_and) || has(:logical_or)
            if has(:logical_and)
                advance
                expr = { type: :logical_and, value: And.new(expr[:value], relational[:value])}
            elsif has(:logical_or)
                advance
                expr = { type: :logical_or, value: Or.new(expr[:value], relational[:value])}
            end
        end
        expr
    end

    def relational
        expr = addition

        while has(:double_equals) || has(:not_equals) ||
            has(:less_than) || has(:less_than_equal) || 
            has(:greater_than) || has(:greater_than_equal)
            if has(:double_equals)
                advance
                expr = { type: :double_equals, value: Equals.new(expr[:value], addition[:value])}
            elsif has(:not_equals)
                advance
                expr = { type: :not_equals, value: NotEquals.new(expr[:value], addition[:value])}
            elsif has(:less_than)
                advance
                expr = { type: :less_than, value: LessThan.new(expr[:value], addition[:value])}
            elsif has(:less_than_equal)
                advance
                expr = { type: :less_than_equal, value: LessThanEqual.new(expr[:value], addition[:value])}
            elsif has(:greater_than)
                advance
                expr = { type: :greater_than, value: GreaterThan.new(expr[:value], addition[:value])}
            elsif has(:greater_than_equal)
                advance
                expr = { type: :greater_than_equal, value: GreaterThanEqual.new(expr[:value], addition[:value])}
            end
        end
        expr
    end

    def addition
        expr = multiplication

        while has(:plus) || has(:hyphen)
            if has(:plus)
                advance
                expr = { type: :plus, value: Add.new(expr[:value], multiplication[:value]) }
            elsif has(:hyphen)
                advance
                expr = { type: :hyphen, value: Subtract.new(expr[:value], multiplication[:value])}
            end
        end
        expr
    end

    def multiplication
        expr = exponent

        while has(:asterisk) || has(:slash) || has(:modulo)
            if has(:asterisk)
                advance
                expr = { type: :asterisk, value: Multiply.new(expr[:value], exponent[:value])}
            elsif has(:slash)
                advance
                expr = { type: :slash, value: Divide.new(expr[:value], exponent[:value]) }
            elsif has(:modulo)
                advance
                expr = { type: :modulo, value: Modulo.new(expr[:value], exponent[:value]) }
            end
        end

        expr
    end

    def exponent
        expr = unary

        while has(:exponent)
            advance
            expr = { type: :exponent, value: Exponent.new(expr[:value], unary[:value]) }
        end
        
        expr
    end

    def unary
        expr = nil
      
        while has(:logical_not) || has(:bitwise_not)
          operator_token = advance
          operand = unary
      
          if operator_token.type == :logical_not
            expr = { type: :logical_not, value: Not.new(operand[:value]) }
          elsif operator_token.type == :bitwise_not
            expr = { type: :bitwise_not, value: BitNot.new(operand[:value]) }
          end
        end
      
        expr ||= primitive
      
        expr
      end
      


    def primitive
        if has(:integerPrim)
            integer
        elsif has(:floatPrim)
            float
        elsif has(:boolPrim)
            bool
        elsif has(:string)
            string
        elsif has(:CellRValue) || has(:left_bracket)
            cell_reference
        elsif has(:left_parenthesis)
            advance
            fac = expression
            if has(:right_parenthesis)
                advance
            else
                raise "Expected ')' after expression."
            end
            fac
        elsif has(:function_call)
            function_call
        else
            raise "Unexpected token: #{@tokens[@i].type}, #{@tokens[@i].text}"
        end
    end

    def integer
        if has(:integerPrim)
            value = advance
            { type: :integerPrim, value: IntPrimitive.new(value.text.to_i) }
        end
    end

    def float
        if has(:floatPrim)
            value = advance
            { type: :floatPrim, value: FloatPrimitive.new(value.text.to_f)}
        end
    end

    def bool
        if has(:boolPrim)
            value = advance
            puts "The: #{value.text}"
            { type: :boolPrim, value: BoolPrimitive.new(value.text) }
        end
    end

    def string
        if has(:string)
            value = advance
            { type: :string, value: StringPrimitive.new(value)}
        end
    end

    def cell_reference
        rvalue = has(:CellRValue)
        advance if rvalue
      
        if has(:left_bracket)
            advance
        end
      
        x_expression = expression
      
        if has(:comma)
            advance
        end

        y_expression = expression

        if has(:right_bracket)
            advance
        end
    
        if rvalue
            { type: :CellRValue, value: CellRValue.new(x_expression[:value], y_expression[:value]) }
        else
            { type: :CellLValue, value: CellLValue.new(x_expression[:value], y_expression[:value]) }
        end
    end

    def function_call
        if has(:function_call)
            call = advance
            args = []
            
            if has(:left_parenthesis)
                advance

                while !has(:right_parenthesis)
                    args << expression
                    advance if has(:comma)
                end

                if has(:right_parenthesis)
                    advance
                else
                    raise "Expected ')' token"
                end
            end

            case call.text
            when 'max'
                {type: :max, value: Max.new(args[0][:value], args[1][:value])}
            when 'min'
                {type: :min, value: Min.new(args[0][:value], args[1][:value])}
            when 'mean'
                {type: :mean, value: Mean.new(args[0][:value], args[1][:value])}
            when 'sum'
                {type: :sum, value: Sum.new(args[0][:value], args[1][:value])}
            when 'float'
                {type: :cast_float, value: FloatPrimitive.new(args[0][:value].value.to_f)}
            when 'int'
                {type: :cast_int, value: IntPrimitive.new(args[0][:value].value.to_i)}
            when 'string'
                {type: :cast_str, value: StringPrimitive.new(args[0][:value].value.to_s)}
            end
        end
    end

    def bitwise_operation
        expr = primitive
        while has(:bitwise_or) || has(:ampersand) || has(:left_shift) || has(:right_shift)
            if has(:bitwise_or)
                advance
                {type: :bitwise_or, value: BitOr.new(expr[:value], primitive[:value])}
            elsif has(:ampersand)
                advance
                {type: :ampersand, value: BitAnd.new(expr[:value], primitive[:value])}
            elsif has(:left_shift)
                advance
                {type: :left_shift, value: BitShiftLeft.new(expr[:value], primitive[:value])}
            elsif has(:right_shift)
                advance
                {type: :right_shift, value: BitShiftRight.new(expr[:value], primitive[:value])}
            end
        end
        expr
    end         
end
