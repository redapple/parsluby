require 'parsluby'
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
        <a href="http://google.ca">I am a link</a>
    </p>
  </body>
</html>
eohtml

selectors = {
    "xpath_p_a"=> "//p/a",
    "css_p_a"=> "p > a",
    "nested"=> {
        "alllinks"=> "//a/@href"
    }
}

parselet = Parsluby.new(selectors)

extracted = parselet.extract(doc)
PP.pp(extracted)
