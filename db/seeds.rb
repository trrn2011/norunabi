# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'xmlsimple'
require 'uri'
require 'net/http'

uri = URI.parse('http://www.ekidata.jp/api/p/13.xml')
xml = Net::HTTP.get(uri)
result = XmlSimple.xml_in(xml)

data = result["line"]

data.each do |line|
  name = line["line_name"][0]
  cd = line["line_cd"][0].to_i
  Line.create(name: name, line_cd: cd, side: "up")
  Line.create(name: name, line_cd: cd, side: "down")
end

