
  module XMLParse

    attr_accessor :nodehash

    def initialize
     @nodehash = Hash.new
    end

    def print_xml(doc)
      doc.toXml
    end

    def parse_annotation(str)
     doc =  Hpricot(str) 
     children = doc.at("textwithnodes").children

     ## Find the TextWithNodes element and then loop through
     ## each child element.  The text next to each node gets associated
     ## with the node id into the hash
     (0..doc.at("textwithnodes").children.size).each { |i| 
       if children[i].class.to_s == 'Hpricot::Elem' 
        @nodehash[children[i].attributes["id"]] = children[i+1] || ''
        i += 2 
       end
      }
     @nodehash
    end

  end



