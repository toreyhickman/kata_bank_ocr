# Parses incoming strings of pipes and underscores into strings of digits

require_relative 'string_digit_mapper'
require_relative 'check_sum'

class Parser

  def self.convert_to_digits(string)
    string = clean_up(string)
    grouped_chars = group_chars(string)
    digits_array = convert_strings_to_digits(grouped_chars)
    digits_string = digits_array.join
    output_string = add_identifiers(digits_string)
  end

  def self.clean_up(string)
    string = remove_empty_fourth_line(string)
    string = remove_new_line_chars(string)
    string
  end

  def self.remove_empty_fourth_line(string)
    string.gsub!(/\ *\Z/, "")
    string
  end

  def self.remove_new_line_chars(string)
    string.gsub!(/\n/, "")
    string
  end

  def self.group_chars(string)
    groups = groups_of_three_chars(string)
    groups = combine_groups(groups)
    groups
  end

  def self.groups_of_three_chars(string)
    string.scan(/.../)
  end

  def self.combine_groups(array)
    groups = []
    (0..8).each do |n|
      groups[n] = array[n] + array[n + 9] + array[n + 18]
    end
    groups
  end

  def self.convert_strings_to_digits(array)
    array.map! do |string|
      string = StringDigitMapper.map.has_key?(string) ? StringDigitMapper.map[string] : "?"
    end
    array
  end

  def self.add_identifiers(string)
    if string.include?("?")
      string << " ILL"
    elsif CheckSum.is_valid?(string) == false
      string << " ERR"
    end
    string
  end

end




# Use Case One Tests
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n| || || || || || || || || |\n|_||_||_||_||_||_||_||_||_|\n                           ") == "000000000"
# puts Parser.convert_to_digits("                           \n  |  |  |  |  |  |  |  |  |\n  |  |  |  |  |  |  |  |  |\n                           ") == "111111111"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n _| _| _| _| _| _| _| _| _|\n|_ |_ |_ |_ |_ |_ |_ |_ |_ \n                           ") == "222222222"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n _| _| _| _| _| _| _| _| _|\n _| _| _| _| _| _| _| _| _|\n                           ") == "333333333"
# puts Parser.convert_to_digits("                           \n|_||_||_||_||_||_||_||_||_|\n  |  |  |  |  |  |  |  |  |\n                           ") == "444444444"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_ |_ |_ |_ |_ |_ |_ |_ |_ \n _| _| _| _| _| _| _| _| _|\n                           ") == "555555555"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_ |_ |_ |_ |_ |_ |_ |_ |_ \n|_||_||_||_||_||_||_||_||_|\n                           ") == "666666666"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n  |  |  |  |  |  |  |  |  |\n  |  |  |  |  |  |  |  |  |\n                           ") == "777777777"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_||_||_||_||_||_||_||_||_|\n|_||_||_||_||_||_||_||_||_|\n                           ") == "888888888"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_||_||_||_||_||_||_||_||_|\n _| _| _| _| _| _| _| _| _|\n                           ") == "999999999"
# puts Parser.convert_to_digits("    _  _     _  _  _  _  _ \n  | _| _||_||_ |_   ||_||_|\n  ||_  _|  | _||_|  ||_| _|\n                           ") == "123456789"

# Use Case Three Tests
# puts Parser.convert_to_digits("    _  _  _  _  _  _     _ \n|_||_|| || ||_   |  |  | _ \n  | _||_||_||_|  |  |  | _|\n                           ") == "49006771? ILL"
# puts Parser.convert_to_digits("    _  _     _  _  _  _  _ \n  | _| _||_| _ |_   ||_||_|\n  ||_  _|  | _||_|  ||_| _ \n                           ") == "1234?678? ILL"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _    \n| || || || || || || ||_   |\n|_||_||_||_||_||_||_| _|  |\n                           ") == "000000051"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_||_||_||_||_||_||_||_||_|\n _| _| _| _| _| _| _| _| _|\n                           ") == "999999999 ERR"

#Use Case Four Tests
puts Parser.convert_to_digits("    _  _     _  _  _  _  _ \n _| _| _||_||_ |_   ||_||_|\n  ||_  _|  | _||_|  ||_| _|\n                           ") == "123456789"
