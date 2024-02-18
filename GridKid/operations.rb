require_relative "expression"
require_relative "runtime"
require_relative "visitor"

class Add < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_add(self, runtime)
    end
end

class Subtract < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_subtract(self, runtime)
    end
end

class Multiply < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_multiply(self, runtime)
    end
end

class Divide < Expression
    attr_accessor :left, :right
        
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_divide(self, runtime)
    end
end

class Modulo < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_modulo(self, runtime)
    end
end

class Exponent < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_exponent(self, runtime)
    end
end

class Negate < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_negate(self, runtime)
    end
end

class And < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_and(self, runtime)
    end
end

class Or < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_or(self, runtime)
    end
end

class Not < Expression
    attr_accessor :value
    
    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_not(self, runtime)
    end
end

class BitAnd < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_bit_and(self, runtime)
    end
end

class BitOr < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_bit_or(self, runtime)
    end
end

class BitXor < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_bit_xor(self, runtime)
    end
end

class BitNot < Expression
    attr_accessor :value
    
    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_bit_not(self, runtime)
    end
end

class BitShiftLeft < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_bit_shift_left(self, runtime)
    end
end

class BitShiftRight < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_bit_shift_right(self, runtime)
    end
end

class Equals < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_equals(self, runtime)
    end
end

class NotEquals < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_not_equals(self, runtime)
    end
end

class LessThan < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_less_than(self, runtime)
    end
end

class LessThanEqual < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_less_than_equal(self, runtime)
    end
end

class GreaterThan < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_greater_than(self, runtime)
    end
end

class GreaterThanEqual < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_greater_than_equal(self, runtime)
    end
end

class FloatToInt < Expression
    attr_accessor :value
    
    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_float_to_int(self, runtime)
    end
end

class IntToFloat < Expression
    attr_accessor :value
    
    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_int_to_float(self, runtime)
    end
end

class Max < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_max(self, runtime)
    end
end

class Min < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_min(self, runtime)
    end
end

class Mean < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_mean(self, runtime)
    end
end

class Sum < Expression
    attr_accessor :left, :right
    
    def initialize(left, right)
        @left, @right = left, right
    end

    def traverse(visitor, runtime)
        visitor.visit_sum(self, runtime)
    end
end
