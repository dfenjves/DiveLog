# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'

def scrape

  fish_list = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/List_of_common_fish_names'))

  fish_list.css('.div-col').each do |alpha|
    alpha.content.split("\n").reject! { |c| c.empty? }.each do |fish|
      fish_in_db = Fish.new(name: fish)
      puts "scraping #{fish}"
      next if fish_list.css("[title=\"" + fish + "\"]").length == 0
      one_fish_page = "http://en.wikipedia.org" + fish_list.css("[title=\"" + fish + "\"]")[0].attributes["href"].value
      # if is_a_disambiguation?(one_fish_page)
      #   page = Nokogiri::HTML(open(one_fish_page))
      #   page.css("#mw-content-text a").each do |link|
      #     fish_url = "http://en.wikipedia.org/" + link["href"].gsub(/^(\/)+/,'')
      #     try_fish = Nokogiri::HTML(open(fish_url))
      #     if try_fish.css('.infobox img').length != 0
      #       one_fish_page = fish_url
      #       break;
      #     end
      #   end
      # end
      fish_in_db.wiki_link = one_fish_page
      one_fish_nokogiri = Nokogiri::HTML(open(one_fish_page))
      if one_fish_nokogiri.css('.infobox img').length != 0
        fish_in_db.picture_link = one_fish_nokogiri.css(".infobox img")[0].attributes["src"].value.gsub(/^(\/)+/,'')
      end
      fish_in_db.save
    end
  end
end

def is_a_disambiguation?(page)
  Nokogiri::HTML(open(page)).content.include?("isambiguation")
end

def disambiguation(page)
  page.css("#mw-content-text a")
end

Fish.delete_all
scrape

