class DocumentReader

  def self.readin(filename)
    lines = []
    file = File.open(filename).each_line { |line| lines << line }
    file.close
    lines
  end

end