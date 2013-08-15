# Places lines from a file in an array

class DocumentReader

  def self.read_in(filename)
    lines = []
    file = File.open(filename).each_line { |line| lines << line }
    file.close
    lines
  end

end
