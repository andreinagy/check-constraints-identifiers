require 'check_xcode_xmls/version'
require 'check_xcode_xmls/arguments_parser.rb'
require 'check_xcode_xmls/shell_adapter.rb'

module CheckXcodeXmls
  class Error < StandardError; end
  # Your code goes here...

  def self.main(args)
    arguments_string = args.join(' ')
    options = Parser.parse(args)

    shell = ShellAdapter.new
    result = shell.process_files(
      options.check_constraints_identifiers,
      options.check_use_autolayout,
      options.ignore_regex_string,
      options.input_directory
    )

    puts "#{$PROGRAM_NAME} #{arguments_string}"
    puts "Total issues: #{result.length || 0}"
    puts result unless result.nil?
  end
end

# TODO: nandrei make switches for each operation
