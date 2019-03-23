SCRIPT = './bin/check-xcode-xmls'.freeze
REPO = 'test/fixtures/'.freeze

# ./bin/check-xcode-xmls -i "(Ignore|Debug)" --check-constraints-identifiers --check-use-autolayout .
REFERENCE_DATA = [
  ['--- Test no arguments prints help',
   '',
   'test/test_references/no_arguments.txt'],

  ['--- Test help argument',
   '-h',
   'test/test_references/help.txt'],

  ['--- Test invalid argument',
   '-z',
   'test/test_references/invalid_argument.txt'],

  ['--- Test ignore off',
   '--check-constraints-identifiers .',
   'test/test_references/ignore_off.txt'],

  ['--- Test ignore on',
   '-i "Ignore" --check-constraints-identifiers .',
   'test/test_references/ignore_on.txt'],

  ['--- Test identifiers on, autolayout off',
   '--check-constraints-identifiers .',
   'test/test_references/constraints_identifiers.txt'],

  ['--- Test identifiers off, autolayout on',
   '--check-use-autolayout .',
   'test/test_references/use_autolayout.txt'],

  ['--- Test missing directory',
   '-i "(Ignore|Debug)" --check-constraints-identifiers --check-use-autolayout',
   'test/test_references/test_missing_directory.txt'],

  ['--- Test echo invocation',
   '-e --check-constraints-identifiers --check-use-autolayout .',
   'test/test_references/test_echo_invocation.txt'],

  ['--- Test print totals',
   '-t --check-constraints-identifiers --check-use-autolayout .',
   'test/test_references/test_print_totals.txt'],

  ['--- Test full arguments',
   '-e -t -i "(Ignore|Debug)" --check-constraints-identifiers --check-use-autolayout .',
   'test/test_references/test_full_arguments.txt']
].freeze

def generate_one_reference(args, file)
  `#{SCRIPT} #{args} > #{file}`
end

def make_test_references
  puts `pwd`
  REFERENCE_DATA.each do |item|
    generate_one_reference(item[1], item[2])
    puts "Generated file #{item[2]}"
  end
end

def diff_output_to_reference(args, file)
  string = `#{SCRIPT} #{args} | diff #{file} -`
  assert string.empty?
end

def test(title, args, reference_file)
  puts
  puts title
  diff_output_to_reference(args, reference_file)
end
