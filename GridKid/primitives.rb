class IntPrimitive < Expression
    attr_reader :value

    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_int_primitive(self, runtime)
    end
end

class FloatPrimitive < Expression
    attr_reader :value
    
    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_float_primitive(self, runtime)
    end
end

class BoolPrimitive < Expression
    attr_reader :value
    
    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_bool_primitive(self, runtime)
    end
end

class StringPrimitive < Expression
    attr_reader :value
    
    def initialize(value)
        @value = value
    end

    def traverse(visitor, runtime)
        visitor.visit_string_primitive(self, runtime)
    end
end

class CellAddress < Expression
    attr_reader :row, :col
    
    def initialize(row, col)
        @row, @col = row, col
    end
end

class CellLValue < CellAddress
    def traverse(visitor, runtime)
        visitor.visit_cell_l(self, runtime)
    end
end

class CellRValue < CellAddress
    def traverse(visitor, runtime)
        visitor.visit_cell_r(self, runtime)
    end
end
