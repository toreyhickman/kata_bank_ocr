class Corrector

  def self.correct_illegible(string, array)
    digit_string = remove_non_digits(string)
    ill_char_index = digit_string.index('?')
    ill_string = array[ill_char_index]
    replacement_options = find_replacement_options(ill_string)
    valid_options = test_replacement_options(digit_string, ill_char_index, replacement_options)
    valid_options.size == 1 ? valid_options[0] : string
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
      valid_options << acct_num.clone if CheckSum.is_valid?(acct_num)
    end
    valid_options
  end
end
