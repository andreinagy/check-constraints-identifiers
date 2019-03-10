require_relative 'helpers'

# Adapter which handles shell access.
class ShellAdapter
  def process_files(
    check_constraints_identifiers,
    check_use_autolayout,
    ignore_regex_string,
    base_path
  )
    result = []
    files = find_files(ignore_regex_string, base_path, /.(xib|storyboard)$/)

    files.each do |file|
      result += parse_xml(
        check_constraints_identifiers,
        check_use_autolayout,
        file
      )
    end
    result
    end
end
