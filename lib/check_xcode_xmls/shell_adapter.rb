require_relative 'helpers'

# Adapter which handles shell access.
class ShellAdapter
  def process_files(ignore_list, base_path)
    puts base_path
    files = find_files(ignore_list, base_path, /.(xib|storyboard)$/)

    files.each do |file|
      file_content = File.open(file, 'r:UTF-8').read
      puts 'file is {file}'
      # language.patterns.each do |pattern|
      #   next if file_content !~ pattern.definition

      #   if file_content !~ pattern.check
      #     puts file + ': ' + pattern.name + ' not called'
      #   end
      # end
    end
    end
end
