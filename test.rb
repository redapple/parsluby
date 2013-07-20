#require 'parsluby'
load 'lib/parsluby.rb'
require 'pp'

doc = Nokogiri::HTML.parse(<<-eohtml)
<html>
  <head>
    <title>Hello World</title>
  </head>
  <body>
    <h1>This is an awesome document</h1>
    <p>
      I am a paragraph
        <a href="http://google.fr">I am a link</a>
    </p>
    <p>
      I am a second paragraph
        <a href="http://google.co.uk">I am a second link</a>
    </p>
  </body>
</html>
eohtml

selectors = {
    "xpath_a_2"=> "(//a)[2]",
    "css_p_a"=> "p > a",
    "nested"=> {
        "alllinks"=> ["//a/@href"]
    }
}

parselet = Parsluby.new(selectors)

extracted = parselet.extract(doc)
PP.pp(extracted)
