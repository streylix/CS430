module Visitor

    #primitives
    def visit_int_primitive(node)
        raise NotImplementedErr
    end

    def visit_float_primitive(node)
        raise NotImplementedErr
    end

    def visit_bool_primitive(node)
        raise NotImplementedErr
    end

    def visit_string_primitive(node)
        raise NotImplementedErr
    end

    def visit_cell_addr(node)
        raise NotImplementedErr
    end
    
    #operations
    def visit_add(node)
        raise NotImplementedErr
    end

    def visit_subtract(node)
        raise NotImplementedErr
    end

    def visit_multiply(node)
        raise NotImplementedErr
    end

    def visit_divide(node)
        raise NotImplementedErr
    end

    def visit_modulo(node)
        raise NotImplementedErr
    end

    def visit_exponent(node)
        raise NotImplementedErr
    end

    def visit_negate(node)
        raise NotImplementedErr
    end

    #logical operations
    def visit_and(node)
        raise NotImplementedErr
    end

    def visit_or(node)
        raise NotImplementedErr
    end

    def visit_not(node)
        raise NotImplementedErr
    end

    #rvalue lvalue
    def visit_cell_l(node)
        raise NotImplementedErr
    end

    def visit_cell_r(node)
        raise NotImplementedErr
    end

    #bitwise
    def visit_bit_and(node)
        raise NotImplementedErr
    end

    def visit_bit_or(node)
        raise NotImplementedErr
    end

    def visit_bit_xor(node)
        raise NotImplementedErr
    end
    
    def visit_bit_not(node)
        raise NotImplementedErr
    end

    def visit_bit_shift_left(node)
        raise NotImplementedErr
    end

    def visit_bit_shift_right(node)
        raise NotImplementedErr
    end

    #equals
    def visit_equals(node)
        raise NotImplementedErr
    end

    def visit_not_equals(node)
        raise NotImplementedErr
    end

    def visit_less_than(node)
        raise NotImplementedErr
    end

    def visit_less_than_equal(node)
        raise NotImplementedErr
    end

    def visit_greater_than(node)
        raise NotImplementedErr
    end

    def visit_greater_than_equal(node)
        raise NotImplementedErr
    end

    #casting
    def visit_int_to_float(node)
        raise NotImplementedErr
    end

    def visit_float_to_int(node)
        raise NotImplementedErr
    end

    #statistics
    def visit_max(node)
        raise NotImplementedErr
    end

    def visit_min(node)
        raise NotImplementedErr
    end

    def visit_mean(node)
        raise NotImplementedErr
    end

    def visit_sum(node)
        raise NotImplementedErr
    end
end