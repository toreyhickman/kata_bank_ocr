# Parses incoming strings of pipes and underscores into strings of digits

class Parser

  def self.convert_to_digits(string)
    string = clean_up(string)
    grouped_chars = group_chars(string)
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

end




# Tests

puts Parser.convert_to_digits(" _  _  _  _  _  _  _  _  _ \n| || || || || || || || || |\n|_||_||_||_||_||_||_||_||_|\n                           ") == 000000000




#   |  |  |  |  |  |  |  |  |
#   |  |  |  |  |  |  |  |  |
                           
# =&gt; 111111111
#  _  _  _  _  _  _  _  _  _ 
#  _| _| _| _| _| _| _| _| _|
# |_ |_ |_ |_ |_ |_ |_ |_ |_ 
                           
# =&gt; 222222222
#  _  _  _  _  _  _  _  _  _ 
#  _| _| _| _| _| _| _| _| _|
#  _| _| _| _| _| _| _| _| _|
                           
# =&gt; 333333333
                           
# |_||_||_||_||_||_||_||_||_|
#   |  |  |  |  |  |  |  |  |
                           
# =&gt; 444444444
#  _  _  _  _  _  _  _  _  _ 
# |_ |_ |_ |_ |_ |_ |_ |_ |_ 
#  _| _| _| _| _| _| _| _| _|
                           
# =&gt; 555555555
#  _  _  _  _  _  _  _  _  _ 
# |_ |_ |_ |_ |_ |_ |_ |_ |_ 
# |_||_||_||_||_||_||_||_||_|
                           
# =&gt; 666666666
#  _  _  _  _  _  _  _  _  _ 
#   |  |  |  |  |  |  |  |  |
#   |  |  |  |  |  |  |  |  |
                           
# =&gt; 777777777
#  _  _  _  _  _  _  _  _  _ 
# |_||_||_||_||_||_||_||_||_|
# |_||_||_||_||_||_||_||_||_|
                           
# =&gt; 888888888
#  _  _  _  _  _  _  _  _  _ 
# |_||_||_||_||_||_||_||_||_|
#  _| _| _| _| _| _| _| _| _|
                           
# =&gt; 999999999
#     _  _     _  _  _  _  _
#   | _| _||_||_ |_   ||_||_|
#   ||_  _|  | _||_|  ||_| _| 
                           
# =&gt; 123456789