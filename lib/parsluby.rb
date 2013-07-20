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
            output = Hash.new
            selector.each do |key, subselector|
                extracted = extract_inner(node, subselector)
                output[key] = extracted
            end
            return output
            selector.each do |key, subselector|
                extracted = extract_inner(node, subselector)
                output[key] = extracted
            end
            return output

        elsif(selector.is_a?(Array))
            output = Array.new
            selector.each do |subselector|

                begin
                    node.css(subselector).each do |r|
                        output.push(r.text)
                    end
                rescue Nokogiri::CSS::SyntaxError
                    node.xpath(subselector).each do |r|
                        output.push(r.text)
                    end
                end

            end
            return output

        else
            begin
                node.css(selector).each do |r|
                    return r.text
                end
            rescue Nokogiri::CSS::SyntaxError
                node.xpath(selector).each do |r|
                    return r.text
                end
            end
        end
    end

end
