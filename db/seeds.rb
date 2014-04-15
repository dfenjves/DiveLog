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
      fish_in_db.picture_link = grab_picture(Nokogiri::HTML(open(one_fish_page)))
      if is_a_disambiguation?(one_fish_page) && !fish_in_db.picture_link
        page = Nokogiri::HTML(open(one_fish_page))
        page.css("#mw-content-text a").each do |link|
          fish_url = "http://en.wikipedia.org/" + link["href"].gsub(/^(\/)+/,'')
          next if fish_url.count(":") > 1 || fish_url.include?("redlink")
          puts "intermediate scrape: #{fish_url}"
          one_fish_picture = grab_picture(Nokogiri::HTML(open(fish_url)))
          if one_fish_picture
            fish_in_db.picture_link = one_fish_picture
            break
          end
        end
      end
      fish_in_db.wiki_link = one_fish_page
      fish_in_db.save
    end
  end
end

def grab_picture(page)
  if page.css('.infobox img').length != 0
    page.css(".infobox img")[0].attributes["src"].value.gsub(/^(\/)+/,'')
  elsif page.css("#mw-content-text .thumb img").length != 0
    page.css("#mw-content-text .thumb img").each do |thumb|
      if thumb.attributes["width"].value.to_i > 150
        return thumb.attributes["src"].value.gsub(/^(\/)+/,'')
      end
    end
    nil
  else
    nil
  end
end

def replace_nils
  Fish.all.each do |fish|
    next if fish.picture_link != nil
    puts "Photo for #{fish.name} not found"
    fish.picture_link = "www.fws.gov/natchitoches/images/coloring%20pages/fish.1.coloring.sheet.gif"
    fish.save
  end
end

def is_a_disambiguation?(page)
  Nokogiri::HTML(open(page)).content.include?("isambiguation")
end

Fish.delete_all
scrape
replace_nils
