require_relative "token.rb"

class Lexer
    def initialize(source)
        @source = source
        @i = 0
        @tokens = []
        @token_so_far = ''
    end

    def has(c)
        @i < @source.length && @source[@i] == c
    end

    def has_letter
        @i < @source.length && 'a' <= @source[@i] && @source[@i] <= 'z'
    end

    def has_next_letter
        @i + 1 < @source.length
    end

    def peek_next_letter
        @source[@i + 1] if has_next_letter
    end

    def capture
        @token_so_far += @source[@i]
        @i += 1
    end

    def abandon
        @token_so_far = ''
        @i += 1
    end

    def add_token(type)
        @tokens.push(Token.new(type, @token_so_far))
        @token_so_far = ''
    end

    def is_digit?(char)
        if @i < @source.length
            char >= '0' && char <= '9'
        else
            false
        end
    end

    def tokenize_number
        start = @i
        while is_digit?(@source[@i]) || @source[@i] == '.'
            capture
        end

        number_string = @source[start...@i]
        type = number_string.include?('.') ? :floatPrim : :integerPrim
        add_token(type)
    end

    def tokenize_string
        if has('"')
            capture
            while has_next_letter && @source[@i] != '"'
                capture
            end
            capture if @source[@i] == '"'
            add_token(:string)
        end
    end

    def tokenize_function
        start = @i
        while has_letter || @source[@i] == '_' || is_digit?(@source[@i])
            capture
        end

        if has('(')
            add_token(:function_call)
        else
            @i = start
            @token_so_far = ''
            while has_letter || @source[@i] == '_' || is_digit?(@source[@i])
                capture
            end
            add_token(:identifier)
        end
    end


    def tokenize
        while @i < @source.length
            case @source[@i]
            when '0'..'9'
                tokenize_number
            when '('
                capture
                add_token(:left_parenthesis)
            when ')'
                capture
                add_token(:right_parenthesis)
            when '{'
                capture
                add_token(:left_curly)
            when '}'
                capture
                add_token(:right_curly)
            when '<'
                if @i + 1 < @source.length && @source[@i + 1] == '='
                    capture
                    capture
                    add_token(:less_than_equal)
                elsif @i + 1 < @source.length && @source[@i + 1] == '<'
                    capture
                    capture
                    add_token(:left_shift)
                else
                    capture
                    add_token(:less_than)
                end
            when '>'
                if @i + 1 < @source.length && @source[@i + 1] == '='
                    capture
                    capture
                    add_token(:greater_than_equal)
                elsif @i + 1 < @source.length && @source[@i + 1] == '>'
                    capture
                    capture
                    add_token(:right_shift)
                else
                    capture
                    add_token(:greater_than)
                end
            when '-'
                capture
                add_token(:hyphen)
            when '+'
                capture
                add_token(:plus)
            when '*'
                capture
                add_token(:asterisk)
            when '/'
                capture
                add_token(:slash)
            when '^'
                capture
                add_token(:exponent)
            when '%'
                capture
                add_token(:modulo)
            when '!'
                if @i + 1 < @source.length && @source[@i + 1] == '='
                    capture
                    capture
                    add_token(:not_equals)
                else
                    capture
                    add_token(:logical_not)
                end
            when '"'
                tokenize_string
            when 'a'..'z', 'A'..'Z', '_'
                tokenize_function
            when "\n"
                capture
                add_token(:linebreak)
            when '='
                if @i + 1 < @source.length && @source[@i + 1] == '='
                    capture
                    capture
                    add_token(:double_equals)
                else
                    capture
                    add_token(:equals)
                end
            when '&'
                if @i + 1 < @source.length && @source[@i + 1] == '&'
                    capture
                    capture # Capture both '&' for '&&'
                    add_token(:logical_and)
                else
                    capture
                    add_token(:ampersand)
                end
            when '|'
                if @i + 1 < @source.length && @source[@i + 1] == '&'
                    capture
                    capture # Capture both '|' for '||'
                    add_token(:logical_or)
                else
                    capture
                    add_token(:bitwise_or)
                end
            when '#'
                capture
                add_token(:CellRValue)
            when '['
                capture
                add_token(:left_bracket)
            when ']'
                capture
                add_token(:right_bracket)
            when ','
                capture
                add_token(:comma)
            when '~'
                capture
                add_token(:bitwise_not)
            when ''
            when ' ' || '\r'
                abandon
            else
                abandon
            end
            # elsif 
            #     while has_letter
            #         capture
            #     end
                
            #     if @token_so_far== 'and'
            #         add_token(:and)
            #     elsif @token_so_far == 'or'
            #         add_token(:or)
            #     elsif @token_so_far == 'xor'
            #         add_token(:xor)
            #     else
            #         add_token(:identifier)
            #     end
        end
        @tokens
    end
end