# Writes elements in an array to a file

class DocumentWriter

  def self.write(array)
    file = File.open(create_file_name, 'w') do |file|
      array.each do |element|
        file.puts element
      end
    end
  end

  def self.create_file_name
    "outputs/#{Time.now.strftime("%Y_%m_%d_%H:%M:%S")}_account_numbers.txt"
  end

end
