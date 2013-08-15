# Validates account numbers

class CheckSum

  def self.is_valid?(str_of_digits)
    dividend = pre_modulo_calculation(str_of_digits)
    dividend % 11 == 0
  end

  def self.pre_modulo_calculation(str_of_digits)
    integers = string_to_array_of_integers(str_of_digits)
    products = int_times_factor(integers)
    products.reduce(&:+)
  end

  def self.string_to_array_of_integers(str_of_digits)
    str_of_digits.split('').map { |char| char.to_i }
  end

  def self.int_times_factor(array_of_integers)
    array_of_integers.each_with_index.map { |n, index| (n * (9 - index)) }
  end
end


# Use Case Two Tests
# puts CheckSum.pre_modulo_calculation("000000000") == 0
# puts CheckSum.pre_modulo_calculation("111111111") == 45
# puts CheckSum.is_valid?("000000000") == true
# puts CheckSum.is_valid?("490867715") == true
# puts CheckSum.is_valid?("711111111") == true
# puts CheckSum.is_valid?("777777177") == true
# puts CheckSum.is_valid?("457508000") == true
# puts CheckSum.is_valid?("664371495") == false
