require_relative "visitor"

class Serializer
    include Visitor

    #primitives
    def visit_int_primitive(node, runtime)
        node.value.to_s
    end

    def visit_float_primitive(node, runtime)
        node.value.to_s
    end

    def visit_bool_primitive(node, runtime)
        node.value.to_s
    end

    def visit_string_primitive(node, runtime)
        "\"#{node.value}\""
    end

    def visit_cell_addr(node, runtime)
        visit_cell_l(node,runtime)
    end


    #arithmetic operators
    def visit_add(node, runtime)
        "(#{node.left.traverse(self, runtime)} + #{node.right.traverse(self, runtime)})"
    end

    def visit_subtract(node, runtime)
        "(#{node.left.traverse(self, runtime)} - #{node.right.traverse(self, runtime)})"
    end

    def visit_multiply(node, runtime)
        "(#{node.left.traverse(self, runtime)} * #{node.right.traverse(self, runtime)})"
    end

    def visit_divide(node, runtime)
        "(#{node.left.traverse(self, runtime)} / #{node.right.traverse(self, runtime)})"
    end

    def visit_modulo(node, runtime)
        "(#{node.left.traverse(self, runtime)} % #{node.right.traverse(self, runtime)})"
    end

    def visit_exponent(node, runtime)
        "(#{node.left.traverse(self, runtime)}^#{node.right.traverse(self, runtime)})"
    end

    def visit_negate(node, runtime)
        "(#{node.left.traverse(self, runtime)} ~ #{node.right.traverse(self, runtime)})"
    end

    #logical operators
    def visit_and(node, runtime)
        "(#{node.left.traverse(self, runtime)} && #{node.right.traverse(self, runtime)})"
    end

    def visit_or(node, runtime)
        "(#{node.left.traverse(self, runtime)} || #{node.right.traverse(self, runtime)})"
    end

    def visit_not(node, runtime)
        "(#{node.left.traverse(self, runtime)} not #{node.right.traverse(self, runtime)})"
    end

    #Cell lvalue and rvalue
    def visit_cell_l(node, runtime)
        row = node.row.traverse(self, runtime)
        col = node.col.traverse(self, runtime)
        "[#{row}, #{col}]"
    end

    def visit_cell_r(node, runtime)
        "#{runtime.grid.get_cell([node.value])}"
    end

    #bitwise
    def visit_bit_and(node, runtime)
        "(#{node.left.traverse(self, runtime)} & #{node.right.traverse(self, runtime)})"
    end

    def visit_bit_or(node, runtime)
        "(#{node.left.traverse(self, runtime)} | #{node.right.traverse(self, runtime)})"
    end

    def visit_bit_xor(node, runtime)
        "(#{node.left.traverse(self, runtime)} ^ #{node.right.traverse(self, runtime)})"
    end

    def visit_bit_not(node, runtime)
        "~(#{node.value})"
    end

    def visit_bit_shift_left(node, runtime)
        "(#{node.left.traverse(self, runtime)} << #{node.right.traverse(self, runtime)})"
    end

    def visit_bit_shift_right(node, runtime)
        "(#{node.left.traverse(self, runtime)} >> #{node.right.traverse(self, runtime)})"
    end

    #relational operators
    def visit_equals(node, runtime)
        "(#{node.left.traverse(self, runtime)} == #{node.right.traverse(self, runtime)})"
    end

    def visit_not_equals(node, runtime)
        "(#{node.left.traverse(self, runtime)} != #{node.right.traverse(self, runtime)})"
    end
    
    def visit_less_than(node, runtime)
        "(#{node.left.traverse(self, runtime)} < #{node.right.traverse(self, runtime)})"
    end

    def visit_less_than_equal(node, runtime)
        "(#{node.left.traverse(self, runtime)} <= #{node.right.traverse(self, runtime)})"
    end

    def visit_greater_than(node, runtime)
        "(#{node.left.traverse(self, runtime)} > #{node.right.traverse(self, runtime)})"
    end

    def visit_greater_than_equal(node, runtime)
        "(#{node.left.traverse(self, runtime)} >= #{node.right.traverse(self, runtime)})"
    end

    #casting
    def visit_float_to_int(node, runtime)
        "(int(#{node.value}))"
    end

    def visit_int_to_float(node, runtime)
        "(float(#{node.value}))"
    end

    #maxminmeansum
    def visit_max(node, runtime)
        "(max(#{node.left.traverse(self, runtime)}, #{node.right.traverse(self, runtime)}))"
    end

    def visit_min(node, runtime)
        "(min(#{node.left.traverse(self, runtime)}, #{node.right.traverse(self, runtime)}))"
    end

    def visit_mean(node, runtime)
        "(mean(#{node.left.traverse(self, runtime)}, #{node.right.traverse(self, runtime)}))"
    end

    def visit_sum(node, runtime)
        "(sum(#{node.left.traverse(self, runtime)}, #{node.right.traverse(self, runtime)}))"
    end
end
