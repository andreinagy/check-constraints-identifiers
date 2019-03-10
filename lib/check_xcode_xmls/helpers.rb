require 'find'

# Convenience utilities.

def find_files(ignore_regex_string, base_path, extension)
  file_paths = []
  ignore_regex = Regex.new(ignore_regex_string)
  Find.find(base_path) do |path|
    next if File.directory? path
    next if path !~ extension
    next if path ~ ignore_regex

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
  # xml_str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
  # <xml>
  #   <foo>
  #     <goo>a</goo>
  #     <hoo>b</hoo>
  #   </foo>
  #   <foo>
  #     <goo>c</goo>
  #     <hoo>d</hoo>
  #   </foo>
  # </xml>"
  
#   <<EOF
# <THING1:things type="Container">
#   <PART1:Id type="Property">1234</PART1:Id>
#   <PART1:Name type="Property">The Name</PART1:Name>
# </THING1:things>
# EOF

  doc = Nokogiri::XML(string)
  puts doc.xpath('document').attribute('type')

  result = search_constraints_without_identifiers(doc.xpath('document'))

  # thing = doc.xpath('//foo')
  # puts thing
  # puts "------ start"
  # puts 'ID   = ' + thing.xpath('//foo').text
  # puts "------ end"
  # puts 'Name = ' + thing.xpath('//Name').text

  result
end

def search_constraints_without_identifiers(doc_xpath)
  results = []
  doc_xpath.children.each { |child|
    array = search_constraints_without_identifiers(child) 
    # puts '----'
    # puts child
    if child.name == "constraint"
      if child.attr('identifier').nil?
        array.push(child)
      end
    end
    results += array unless array.nil?
  }
  
  results

end