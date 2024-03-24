require_relative "expression"
require_relative "runtime"
require_relative "visitor"

class Evaluator
    include Visitor

    #primitives
    def visit_int_primitive(node, runtime)
        node
    end

    def visit_float_primitive(node, runtime)
        node
    end

    def visit_bool_primitive(node, runtime)
        node
    end

    def visit_string_primitive(node, runtime)
        node
    end

    def visit_cell_addr(node, runtime)
        node.value
    end

    def check_prims(value)
        unless value.is_a?(IntPrimitive) || value.is_a?(FloatPrimitive)
            raise "Expected #{value} to be an int or float primitve but was not"
        end
    end

    def check_prims_bool(value)
        unless value.is_a?(BoolPrimitive)
            raise "Expected #{value} to be a boolean primitive but was not"
        end
    end

    #operations
    def visit_add(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        result = left.value + right.value
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_subtract(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        result = left.value - right.value
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_multiply(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        result = left.value * right.value
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_divide(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        result = left.value / right.value
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_modulo(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        result = left.value % right.value
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_exponent(node, runtime)
        # for i in 0..node.right.traverse(self, runtime) do
        #     node.left.traverse(self, runtime) * node.left.traverse(self, runtime)
        # end
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        for i in 0..right.value do
            left.value *= left.value
        end
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_negate(node, runtime)
        value = node.traverse(self, runtime)
        check_prims(value)

        result = -(value.value)
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_and(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims_bool(left)
        check_prims_bool(right)

        BoolPrimitive.new((left.value == true && right.value == true))
    end

    def visit_or(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims_bool(left)
        check_prims_bool(right)

        BoolPrimitive.new((left.value == true || right.value == true))
    end

    def visit_not(node, runtime)
        value = node.value.traverse(self, runtime).value
        BoolPrimitive.new(!value)
    end

    def visit_cell_l(node, runtime)
        row = node.row.traverse(self, runtime).value
        col = node.col.traverse(self, runtime).value

        unless row.is_a?(Integer) && col.is_a?(Integer)
            raise "Operands must be Integers"
        end

        result = [row, col]
        result
    end

    def visit_cell_r(node, runtime)
        row = node.row.traverse(self, runtime).value
        col = node.col.traverse(self, runtime).value

        unless row.is_a?(Integer) && col.is_a?(Integer)
            raise "Operands must be Integers, instead got #{row}"
        end

        result = runtime.grid.get_cell([row, col])
        unless result
            raise "Cell location #{result} contains no values"
        end

        result
    end

    def visit_bit_and(node, runtime)
        node.left.traverse(self, runtime) & node.right.traverse(self, runtime)
    end

    def visit_bit_or(node, runtime)
        node.left.traverse(self, runtime) | node.right.traverse(self, runtime)
    end

    def visit_bit_xor(node, runtime)
        node.left.traverse(self, runtime) ^ node.right.traverse(self, runtime)
    end

    def visit_bit_not(node, runtime)
        ~(node.value)
    end

    def visit_bit_shift_left(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        result = left.value << right.value
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_bit_shift_right(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        check_prims(left)
        check_prims(right)

        result = left.value >> right.value
        if (result.is_a?(Integer))
            IntPrimitive.new(result)
        else
            FloatPrimitive.new(result)
        end
    end

    def visit_equals(node, runtime)
        BoolPrimitive.new(node.left.traverse(self, runtime).value == node.right.traverse(self, runtime).value)
    end

    def visit_not_equals(node, runtime)
        BoolPrimitive.new(node.left.traverse(self, runtime).value != node.right.traverse(self, runtime).value)
    end

    def visit_less_than(node, runtime)
        BoolPrimitive.new(node.left.traverse(self, runtime).value < node.right.traverse(self, runtime).value)
    end

    def visit_less_than_equal(node, runtime)
        BoolPrimitive.new(node.left.traverse(self, runtime).value <= node.right.traverse(self, runtime).value)
    end

    def visit_greater_than(node, runtime)
        BoolPrimitive.new(node.left.traverse(self, runtime).value > node.right.traverse(self, runtime).value)
    end

    def visit_greater_than_equal(node, runtime)
        BoolPrimitive.new(node.left.traverse(self, runtime).value >= node.right.traverse(self, runtime).value)
    end

    def visit_float_to_int(node, runtime)
        node.value.value.to_i
        IntPrimitive.new(node.value.value)
    end

    def visit_int_to_float(node, runtime)
        node.value.value.to_f
        FloatPrimitive.new(node.value.value)
    end

    def visit_max(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        left_max = 0
        right_max = 0
        max = 0
        for i in 0..left.size-1 do
            if left_max < left[i]
                left_max = left[i]
            end
        end
        for i in 0..right.size-1 do
            if right_max < right[i]
                right_max = right[i]
            end
        end
        if left_max < right_max
            max = right_max
        else
            max = left_max
        end
        if (max.is_a?(Integer))
            IntPrimitive.new(max)
        else
            FloatPrimitive.new(max)
        end
    end

    def visit_min(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        left_min = 99999
        right_min = 99999
        for i in 0..left.size-1 do
            if (left[i] < left_min)
                left_min = left[i]
            end
        end
        for i in 0..right.size-1 do
            if right[i] < right_min
                right_min = right[i]
            end
        end
        if left_min > right_min
            min = right_min
        else
            min = left_min
        end
        if (min.is_a?(Integer))
            IntPrimitive.new(min)
        else
            FloatPrimitive.new(min)
        end
    end

    def visit_mean(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        leftsum = 0
        rightsum = 0
        for i in 0..left.size-1 do
            leftsum += left[i]
        end
        for i in 0..right.size-1 do
            rightsum += right[i]
        end
        sum = leftsum + rightsum
        sum = sum / (left.size + right.size)
        if (sum.is_a?(Integer))
            IntPrimitive.new(sum)
        else
            FloatPrimitive.new(sum)
        end
    end

    def visit_sum(node, runtime)
        left = node.left.traverse(self, runtime)
        right = node.right.traverse(self, runtime)
        leftsum = 0
        rightsum = 0
        for i in 0..left.size-1 do
            leftsum += left[i]
        end
        for i in 0..right.size-1 do
            rightsum += right[i]
        end
        sum = leftsum + rightsum
        if (sum.is_a?(Integer))
            IntPrimitive.new(sum)
        else
            FloatPrimitive.new(sum)
        end
    end
end