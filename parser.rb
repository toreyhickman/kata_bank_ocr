# Parses incoming strings of pipes and underscores into strings of digits

require_relative 'string_digit_mapper'
require_relative 'check_sum'
require_relative 'corrector'
require_relative 'document_reader'
require_relative 'document_writer'

class Parser

  def self.parse(filename)
    lines = DocumentReader.read_in(filename)
    grouped_lines = group_lines(lines)
    acct_nums = format_for_output(grouped_lines)
    DocumentWriter.write(acct_nums)
  end

  def self.group_lines(array)
    grouped_lines = []
    grouped_lines << array.slice!(0..3) until array.size < 4
    grouped_lines.map { |x| x.join('') }
  end

  def self.format_for_output(array)
    formatted_acct_nums = []
    array.each { |string| formatted_acct_nums << convert_to_digits(string) }
    formatted_acct_nums
  end

  def self.convert_to_digits(string)
    string = clean_up(string)
    grouped_chars = group_chars(string)
    digits_array = convert_strings_to_digits(grouped_chars)
    digits_string = digits_array.join
    marked_string = add_identifiers(digits_string)
    output_string = needs_correction?(marked_string) ? make_corrections(marked_string, grouped_chars) : marked_string
    output_string
  end

  def self.clean_up(string)
    string = remove_empty_fourth_line(string)
    string = remove_new_line_chars(string)
    string
  end

  def self.remove_empty_fourth_line(string)
    string.gsub!(/\ *\n\Z/, "")
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
    digits_array = array.map do |string|
      string = StringDigitMapper.map.has_key?(string) ? StringDigitMapper.map[string] : "?"
    end
    digits_array
  end

  def self.add_identifiers(string)
    if string.include?("?")
      string << " ILL"
    elsif CheckSum.is_valid?(string) == false
      string << " ERR"
    end
    string
  end

  def self.needs_correction?(string)
    string.match(/ILL/) || string.match(/ERR/)
  end

  def self.make_corrections(string, array)
    string.match(/ILL/) ? Corrector.correct_illegible(string, array) : Corrector.correct_invalid(string, array)
  end
end


if ARGV[0]
  Parser.parse(ARGV[0])
else
  puts "From which file would you like to read account numbers?"
  filename = gets.chomp
  Parser.parse(filename)
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

# Use Case Four Tests
# Illegibles
# puts Parser.convert_to_digits("    _  _     _  _  _  _  _ \n _| _| _||_||_ |_   ||_||_|\n  ||_  _|  | _||_|  ||_| _|\n                           \n") == "123456789"
# puts Parser.convert_to_digits(" _     _  _  _  _  _  _    \n| || || || || || || ||_   |\n|_||_||_||_||_||_||_| _|  |\n                           \n") == "000000051"
# puts Parser.convert_to_digits("    _  _  _  _  _  _     _ \n|_||_|| ||_||_   |  |  | _ \n  | _||_||_||_|  |  |  | _|\n                           \n") == "490867715"
# Errors
# puts Parser.convert_to_digits("                           \n  |  |  |  |  |  |  |  |  |\n  |  |  |  |  |  |  |  |  |\n                           \n") == "711111111"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n  |  |  |  |  |  |  |  |  |\n  |  |  |  |  |  |  |  |  |\n                           \n") == "777777177"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n _|| || || || || || || || |\n|_ |_||_||_||_||_||_||_||_|\n                           \n") == "200800000"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n _| _| _| _| _| _| _| _| _|\n _| _| _| _| _| _| _| _| _|\n                           \n") == "333393333"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_||_||_||_||_||_||_||_||_|\n|_||_||_||_||_||_||_||_||_|\n                           \n") == "888888888 AMB ['888886888', '888888880', '888888988']"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_ |_ |_ |_ |_ |_ |_ |_ |_ \n _| _| _| _| _| _| _| _| _|\n                           \n") == "555555555 AMB ['555655555', '559555555']"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_ |_ |_ |_ |_ |_ |_ |_ |_ \n|_||_||_||_||_||_||_||_||_|\n                           \n") == "666666666 AMB ['666566666', '686666666']"
# puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n|_||_||_||_||_||_||_||_||_|\n _| _| _| _| _| _| _| _| _|\n                           \n") == "999999999 AMB ['899999999', '993999999', '999959999']"
# puts Parser.convert_to_digits("    _  _  _  _  _  _     _ \n|_||_|| || ||_   |  |  ||_ \n  | _||_||_||_|  |  |  | _|\n                           \n") == "490067715 AMB ['490067115', '490067719', '490867715']"
