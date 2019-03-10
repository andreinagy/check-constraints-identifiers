require 'find'

# Convenience utilities.

def find_files(ignore_regex_string, base_path, extension)
  file_paths = []
  ignore_regex = Regexp.new(ignore_regex_string)
  Find.find(base_path) do |path|
    next if File.directory? path
    next if path !~ extension
    next if path =~ ignore_regex

    file_paths << path
  end
  file_paths
end

class XcodeXml

def extension
  'implement in subclass'
end

end

class Xib < XcodeXml

  def extension
    '.xib'
  end


end

class Storyboard < XcodeXml

  def extension
    '.storyboard'
  end
  # eg. segue identifier

end

require 'nokogiri'
def parse_xml(file)
  string = File.open(file, 'r:UTF-8').read
  doc = Nokogiri::XML(string)
  puts doc.xpath('document').attribute('type')

  result = search_constraints_without_identifiers(file, doc.xpath('document'))

  result
end

def search_constraints_without_identifiers(file, doc_xpath)
  results = []
  doc_xpath.children.each { |child|
    array = search_constraints_without_identifiers(file, child) 
    # puts '----'
    # puts child
    if child.name == "constraint"
      if child.attr('identifier').nil?
        array.push("#{file}: constraint #{child.attr('id')} doesn't have an identifier.")
      end
    end
    results += array unless array.nil?
  }
  results
end