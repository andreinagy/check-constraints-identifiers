require_relative 'helpers'

# Adapter which handles shell access.
class ShellAdapter
  def process_files(ignore_regex_string, base_path)
    result = []
    files = find_files(ignore_regex_string, base_path, /.(xib|storyboard)$/)

    files.each do |file|
      result += parse_xml(file)
    end
    result
    end
end
