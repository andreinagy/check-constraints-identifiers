require 'find'

# Convenience utilities.

def find_files(ignore_list, base_path, extension)
  file_paths = []
  Find.find(base_path) do |path|
    next if File.directory? path
    next if path !~ extension

    ignore_matches = (ignore_list || []).select do |item|
      path.include? item
    end
    should_ignore = ignore_matches.any?

    file_paths << path unless should_ignore
  end
  file_paths
end
