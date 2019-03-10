require 'find'

class XcodeXml
  def self.extension
    'implement in subclass'
  end

  def self.check_if_file_uses_autolayout(file, doc_xpath)
    # <document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="14460.31" targetRuntime="iOS.CocoaTouch"
    # propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    if doc_xpath.attribute('useAutolayout').nil?
      return ["#{file}: doesn't use autolayout."]
    end
    nil
  end

  def self.search_constraints_without_identifiers(file, doc_xpath)
    result = []
    doc_xpath.children.each do |child|
      array = search_constraints_without_identifiers(file, child)
      # puts '----'
      # puts child
      if child.name == 'constraint'
        if child.attr('identifier').nil?
          array.push("#{file}: constraint #{child.attr('id')} doesn't have an identifier.")
        end
      end
      result += array unless array.nil?
    end
    result
  end
end

class Xib < XcodeXml
  def self.extension
    /.xib$/
  end
end

class Storyboard < XcodeXml
  def self.extension
    /.storyboard$/
  end
  # eg. segue identifier
end

# Convenience utilities.

def find_files(ignore_regex_string, base_path, extension)
  file_paths = []
  ignore_regex = Regexp.new(ignore_regex_string)
  puts ignore_regex
  Find.find(base_path) do |path|
    next if File.directory? path
    next if path !~ extension
    next if path =~ ignore_regex

    file_paths << path
  end
  file_paths
end

require 'nokogiri'
def parse_xml(file)
  string = File.open(file, 'r:UTF-8').read
  doc = Nokogiri::XML(string)
  # puts doc.xpath('document').attribute('type')
  result = []

  [Xib,
   Storyboard].each do |item|

    next if file !~ item.extension

    autolayoutValue = item.check_if_file_uses_autolayout(file, doc.xpath('document'))
    result += autolayoutValue unless autolayoutValue.nil?

    constraintsValues = item.search_constraints_without_identifiers(file, doc.xpath('document'))
    result += constraintsValues unless constraintsValues.nil?
  end
  # result = search_constraints_without_identifiers(file, doc.xpath('document'))
  result
end
