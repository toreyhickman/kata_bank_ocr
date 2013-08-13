class Corrector

  def self.correct_illegible(string, array)
    digit_string = remove_non_digits(string)
    ill_char_index = digit_string.index('?')
    ill_string = array[ill_char_index]
    replacement_options = find_replacement_options(ill_string)

    #puts replacement_options.inspect

    valid_replacement_options = test_replacement_options(digit_string, ill_char_index, replacement_options)
    return valid_replacement_options[0] if valid_replacement_options.size == 1
  end

  def self.correct_invalid(string, array)
    string
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

  def self.test_replacement_options(string, index, array)
    valid_options = []
    array.each do |char_string|
      acct_num = string
      acct_num[index] = StringDigitMapper.map[char_string]
      puts "With #{StringDigitMapper.map[char_string]} ..."
      puts CheckSum.is_valid?(acct_num)

      # Add valid digits to valid_options array

    end
    valid_options
  end
end
