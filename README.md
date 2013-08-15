My solution to the KataBankOCR at codingdojo.org in Ruby

http://codingdojo.org/cgi-bin/wiki.pl?KataBankOCR




To parse a file, from the command line run the command ...

  $ ruby parser.rb filename

The program will output a new text file in the outputs/ directory.




The test cases from User Story 4 have been included in the file readin.txt. To parse this file run ...

  $ ruby parser.rb readin.txt




The strings being fed to the parser consist of underscores, pipes, spaces, and newline characters.  In order to structure the document to be parsed correctly, your editor should not remove trailing white space from this file.
