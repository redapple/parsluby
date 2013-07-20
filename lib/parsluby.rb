require 'nokogiri'

class Parsluby

    def initialize(selector_hash)
        if(selector_hash.is_a?(Hash))
            @selector_tree = selector_hash
        end
    end


    def extract(document)
        return extract_inner(document, @selector_tree)
    end


    def extract_inner(node, selector)

        if(selector.is_a?(Hash))
            output = {}
            selector.each do |key, subselector|
                #puts "-----------------------------"
                #puts "key: "
                #puts key
                #puts "subselector: "
                #puts subselector
                extracted = extract_inner(node, subselector)
                #puts "extracted: "
                #puts extracted
                output[key] = extracted
            end
            return output

        else
            node.search(selector).each do |r|
                return r.text
            end
        end
    end

end
