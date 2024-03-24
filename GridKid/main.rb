require_relative "visitor"
require_relative "evaluator"
require_relative "expression"
require_relative "grid"
require_relative "operations"
require_relative "primitives"
require_relative "runtime"
require_relative "serializer"

#initialize
runtime = Runtime.new
evaluator = Evaluator.new

#run personal tests
puts "--==Personal tests==--\n\n"

# Type declaration
integer = IntPrimitive.new(7)
floating = FloatPrimitive.new(12.9)
boolie = BoolPrimitive.new(false)
stringie = StringPrimitive.new("Testing")
never_to_be_used_cell_addr = CellAddress.new(integer, IntPrimitive.new(12))

puts "--Values--\n
Int: #{Serializer.new.visit_int_primitive(integer, runtime)}\n
Float: #{Serializer.new.visit_float_primitive(floating, runtime)}\n
Bool: #{Serializer.new.visit_bool_primitive(boolie, runtime)}\n
String: #{Serializer.new.visit_string_primitive(stringie, runtime)}\n
cell: #{Serializer.new.visit_cell_addr(never_to_be_used_cell_addr, runtime)}\n\n"

int_math = Add.new(integer, IntPrimitive.new(2))
int_math.traverse(evaluator, runtime)

puts "--the usual logic--\n\n"
puts "#{integer.value} + #{IntPrimitive.new(2).value} = #{int_math.traverse(evaluator, runtime).value}"
puts "#{floating.value} - #{FloatPrimitive.new(0.6).value} = #{Subtract.new(floating, FloatPrimitive.new(0.6)).traverse(evaluator, runtime).value}"
puts "#{floating.value} * #{integer.value} = #{Multiply.new(floating, integer).traverse(evaluator, runtime).value}"
puts "#{floating.value} / #{integer.value} = #{Divide.new(floating, integer).traverse(evaluator, runtime).value}\n\n"

puts "--boolean logic--\n\n"
puts "Bool = #{boolie.value} ... !Bool = #{Not.new(boolie.value).traverse(evaluator, runtime).value}"
not_boolie = BoolPrimitive.new(Not.new(boolie.value).traverse(evaluator, runtime).value)
puts "#{boolie.value} and #{not_boolie.value} = #{And.new(boolie, not_boolie).traverse(evaluator, runtime).value}"
puts "#{boolie.value} or #{not_boolie.value} = #{Or.new(boolie, not_boolie).traverse(evaluator, runtime).value}\n\n"

puts "--lvalues and rvalues--\n\n"
#declare values
cell_pos = runtime.grid.set_cell([1, 3], IntPrimitive.new(42))
runtime.grid.set_cell([4, 9], IntPrimitive.new(25))
puts"created two cells at locations [1, 3] and [4, 9] containing values #{runtime.grid.get_cell([1, 3]).value} and #{runtime.grid.get_cell([4, 9]).value} respectively"

l_value = CellLValue.new(IntPrimitive.new(1), IntPrimitive.new(3))
r_value = CellRValue.new(IntPrimitive.new(4), IntPrimitive.new(9))
puts "Value contained within l_value: #{l_value.traverse(evaluator, runtime)}
Value contained within r_value: #{r_value.traverse(evaluator, runtime).value}\n"
puts "Setting both values to one cell:"
l_value, r_value = cell_pos, cell_pos
puts "New value contained within l_value: #{l_value.traverse(evaluator, runtime).value}
New value contained within r_value: #{r_value.traverse(evaluator, runtime).value}\n\n"

puts "--skipping some and just doing statistical functions--\n\n"
stats_bundle_1 = CellLValue.new(IntPrimitive.new(3), IntPrimitive.new(6))
stats_bundle_2 = CellLValue.new(IntPrimitive.new(9), IntPrimitive.new(12))
summing = Sum.new(stats_bundle_1, stats_bundle_2)
meaning = Mean.new(stats_bundle_1, stats_bundle_2)
minning = Min.new(stats_bundle_1, stats_bundle_2)
maxxing = Max.new(stats_bundle_1, stats_bundle_2) #lol
puts "summing cell_l values [3, 6] and [9, 12] together gives us: #{summing.traverse(evaluator, runtime).value}"
puts "the mean of the sum of cell_l values [3, 6] and [9, 12] is: #{meaning.traverse(evaluator, runtime).value}"
puts "the min of cell_l values [3, 6] and [9, 12] is: #{minning.traverse(evaluator, runtime).value}"
puts "the max of cell_l values [3, 6] and [9, 12] is: #{maxxing.traverse(evaluator, runtime).value}\n\n"


# string1 = StringPrimitive.new("Hello ")
# string2 = StringPrimitive.new("World!")
# str_addr1 = CellAddress.new(IntPrimitive.new(1), IntPrimitive.new(0))
# str_addr2 = CellAddress.new(IntPrimitive.new(0), IntPrimitive.new(1))

# runtime.grid.set_cell(str_addr1, string1)
# runtime.grid.set_cell(str_addr2, string2)

# puts "String: #{Serializer.new.visit_string_primitive(string1, runtime)} at addr #{Serializer.new.visit_cell_addr(str_addr1, runtime)}\nis added with String #{Serializer.new.visit_string_primitive(string2, runtime)} at addr #{Serializer.new.visit_cell_addr(str_addr2, runtime)} to get:"

# expression = Add.new(runtime.grid.get_cell(str_addr1), runtime.grid.get_cell(str_addr2))
# result = expression.traverse(evaluator, runtime)

# puts "String Evaluation Result: #{result}\n\n"

# ***** STRING CONCATENATION IS NOT APPLICABLE *****

#Required tests:
puts "--==Required tests==--\n\n"
puts "Attempting: (7 * 4 + 3) % 12 = 7\n\n"

expression = 
Modulo.new(
    Add.new(
        Multiply.new(
            IntPrimitive.new(7), IntPrimitive.new(4)),
    IntPrimitive.new(3)), 
IntPrimitive.new(12))

result = expression.traverse(evaluator, runtime)

puts "1. Result: #{result.value}, Works? #{Evaluator.new.visit_equals(Equals.new(result, IntPrimitive.new(7)), runtime).value}\n"

runtime.grid.set_cell([1, 1], IntPrimitive.new(4))
runtime.grid.set_cell([0, 0], IntPrimitive.new(1))
runtime.grid.set_cell([0, 1], IntPrimitive.new(2))
runtime.grid.set_cell([2, 4], IntPrimitive.new(8))

expres = Add.new(IntPrimitive.new(1), IntPrimitive.new(1))
res = expres.traverse(evaluator, runtime)

cell_rvalue = CellRValue.new(res, IntPrimitive.new(4))
shifted_expression = BitShiftLeft.new(cell_rvalue, IntPrimitive.new(3))

if Equals.new(shifted_expression.traverse(evaluator, runtime), IntPrimitive.new(64))
    puts "2. #[1 + 1, 4] << 3 executed correctly\n"
end

cell_rvalue1 = runtime.grid.get_cell([0, 0])
cell_rvalue2 = runtime.grid.get_cell([0, 1])
comparison_expression = LessThan.new(cell_rvalue1, cell_rvalue2)

if comparison_expression.traverse(evaluator, runtime)
    puts "3. #[0, 0] < #[0, 1] was evaluated correctly\n"
end

logic_expression = Not.new(GreaterThan.new(FloatPrimitive.new(3.3), FloatPrimitive.new(3.2)))
if Equals.new(logic_expression.traverse(evaluator, runtime).value, BoolPrimitive.new(false)) # if logic_expression.traverse(evaluator, runtime).value == false 
    puts "4. !(3.3 > 3.2) was false, Logic and comparison was a success!\n"
end

sum_expression = Sum.new(
    CellLValue.new(IntPrimitive.new(1), IntPrimitive.new(2)),
    CellLValue.new(IntPrimitive.new(5), IntPrimitive.new(3))
)

if (Equals.new(sum_expression.traverse(evaluator, runtime), IntPrimitive.new(11))) # Assuming the sum of two Cell lvalues are their respective row and column values added together
    puts "5. sum([1, 2], [5, 3]) successfully evaluated\n"
end

float_expression = Divide.new(
    IntToFloat.new(IntPrimitive.new(7)),
    IntPrimitive.new(2)
)

if (Equals.new(float_expression.traverse(evaluator, runtime), FloatPrimitive.new(3.5)))
    puts "6. float(7) / 2 evaluated successfully!\n"
end