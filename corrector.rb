class Corrector

  def self.correct_illegible(string, array)
    digit_string = remove_non_digits(string)
    ill_char_index = digit_string.index('?')
    ill_string = array[ill_char_index]
    replacement_options = find_replacement_options(ill_string)
    valid_options = test_ill_replacement_options(digit_string, ill_char_index, replacement_options)
    valid_options.size == 1 ? valid_options[0] : string
  end

  def self.correct_invalid(string, array)
    digit_string = remove_non_digits(string)
    possibilities_at_each_index = find_possibilities(array)
    possibile_acct_nums = create_possible_numbers(digit_string, possibilities_at_each_index)
    valid_options = test_possible_acct_nums(possibile_acct_nums)
    build_output(string, digit_string, valid_options)
  end

  def self.create_possible_numbers(string, array_of_arrays)
    possible_acct_numbers = []
    array_of_arrays.each_with_index do |array, index|
      array.each do |digit|
        editable_string = string.clone
        editable_string[index] = digit
        possible_acct_numbers << editable_string
      end
    end
    possible_acct_numbers
  end

  def self.test_possible_acct_nums(array)
    array.select { |acct_num| CheckSum.is_valid?(acct_num) }
  end

  def self.build_output(string, digit_string, array)
    return string if array.size == 0
    return array[0] if array.size == 1
    build_amb(digit_string, array)
  end

  def self.build_amb(string, array)
    sorted_array = array.sort
    quoted_elements = sorted_array.map { |x| "'#{x}'" }
    "#{string} AMB [#{quoted_elements.join(', ')}]"
  end

  def self.find_possibilities(array)
    possibilities_at_index = array.map { |char_string| find_replacement_options(char_string) }
    possibilities_at_index.each do |nested_array|
      nested_array.map! { |char_string| StringDigitMapper.map[char_string] }
    end
    possibilities_at_index
  end

  def self.find_replacement_options(string)
    possibilities = StringDigitMapper.keys
    possibilities.select! { |x| count_diff_chars(string, x) == 1 }
  end

  def self.count_diff_chars(string1, string2)
    count = 0
    (0..(string1.length - 1)).each do |index|
      count += 1 if string1[index] != string2[index]
    end
    count
  end

  def self.remove_non_digits(string)
    string.slice(/^[\d|?]{9}/)
  end

  def self.test_ill_replacement_options(string, index, array)
    valid_options = []
    array.each do |char_string|
      acct_num = string
      acct_num[index] = StringDigitMapper.map[char_string]
      valid_options << acct_num.clone if CheckSum.is_valid?(acct_num)
    end
    valid_options
  end
end
