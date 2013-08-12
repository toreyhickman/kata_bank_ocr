class CheckSum

  def self.is_valid?(string_of_digits)
    dividend = pre_modulo_calculation(string_of_digits)
  end

  def self.pre_modulo_calculation(string)
    integers = string_to_array_of_integers(string)
    products = int_times_factor(integers)
    products.reduce(&:+)
  end

  def self.string_to_array_of_integers(string)
    string.split('').map { |char| char.to_i }
  end

  def self.int_times_factor(array)
    array.each_with_index.map { |n, index| (n * (9 - index)) }
  end
end


# tests
puts CheckSum.pre_modulo_calculation("000000000") == 0
puts CheckSum.pre_modulo_calculation("111111111") == 45
