# Parses incoming strings of pipes and underscores into strings of digits

class Parser

  def self.convert_to_digits(string)
    string = clean_up(string)
    string
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