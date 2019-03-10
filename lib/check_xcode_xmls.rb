require 'check_xcode_xmls/version'
require 'check_xcode_xmls/arguments_parser.rb'
require 'check_xcode_xmls/shell_adapter.rb'

module CheckXcodeXmls
  class Error < StandardError; end
  # Your code goes here...

  def self.main(args)
    options = Parser.parse(args)

    shell = ShellAdapter.new
    result = shell.process_files(options.ignore_regex_string, 
      options.input_directory)

    if result.empty? || result.nil? 
      puts 'No constraints identifiers missing.'
    else 
      puts 'Constraints with missing identifiers:'
      puts result
    end
  end
end

# TODO: nandrei append file to output.
# TODO: nandrei make ignoring work.
# TODO: nandrei make switches for each operation