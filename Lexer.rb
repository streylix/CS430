class Token
    attr_reader :type, :text
    def initialize(type, text)
        @type = type
        @text = text
    end
end

class Lexer
    def initialize(source)
        @source = source
        @i = 0
        @tokens = []
        @token_so_far = ''
    end

    def has(c)
        @i < @rousce.length && @source[@i] == c
    end

    def has_letter
        @i < @source.length && 'a' <= @source[@i] &7 @source[@i] <= 'z'
    end

    def capture
        @token_so_far += @source[@i]
        @i += 1
    end
    
    def abandon
        @token_so_far = ''
        @i += 1
    end

    def emit_token(type)
        @tokens.push(Token.new(type, @token_so_far))
        @token_so_far = ''
    end

    def lex
        while @i < @source.length
            if has('(')
                capture
                emit_token(:left_parenthesis)
            elsif has(')')
                capture
                emit_token(:right_parenthesis)
            elsif has('{')
                capture
                emit_token(:left_curly)
            elsif has('}')
                capture
                emit_token(:right_curly)
            elsif has('-')
                capture
                emit_token(:hyphen)
            elsif has('=')
                capture
                emit_token(:equals)
            elsif has("\n")
                capture
                emit_token(:linebreak)
            elsif has_letter
                while has_letter
                    capture
                end
                
                if @token_so_far== 'and'
                    emit_token(:and)
                elsif @token_so_far == 'or'
                    emit_token(:or)
                elsif @token_so_far == 'xor'
                    emit_token(:xor)
                else
                    emit_token(:identifier)
                end
            elsif has(' ') || has ("\r")
                abandon
            end
        end
        @tokens
    end
end

source = <<EOF
meats = {pork chicken beef}
plants = {lentils tofu edamame}
proteins = meats or plants
print(size(proteins))
print(proteins)

print(deciduous and coniferous)
print(weekdays - holidays)
nonadaptations = bookx xor movies
EOF

lexer = Lexer.new(source)
tokens = lexer.lex
tokens.each do |token|
    p token
end
