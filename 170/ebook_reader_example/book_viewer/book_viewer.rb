require "sinatra"
require "sinatra/reloader"
require "pry"

before do
  @toc_data = File.read("data/toc.txt").split("\n")
end

def add_paragraph_tags(text)
  id_count = 1
  text.split("\n\n").each do |line|
    unless line.empty?
      line.insert(0, "<p id=#{id_count}>")
      line.insert(-1,'</p>')
      id_count += 1
    end
  end.join
end

def match_chapters(search_term)
  matches = []
  unless search_term.nil?
    Dir["data/chp*"].each do |string|
      chp_content = File.read(string)
      if chp_content.include?(search_term)
        matches << string.gsub!("data/chp","").gsub!(".txt","")
      end
    end  
  end
  
  matches.map!(&:to_i)
  
  matches.sort.map do | idx |
    @toc_data[idx - 1]
  end
end

def match_paragraphs(chapter_text, search_term)
  matches = {}
  chapter_text.split("\n\n").each_with_index do |line, idx|
    if line.include?(search_term)
      matches[idx + 1] = line
    end
  end
  matches
end


helpers do
  def add_paragraph_tags(text)
    id_count = 1
    text.split("\n\n").each do |line|
      unless line.empty?
        line.insert(0, "<p id=#{id_count}>")
        line.insert(-1,'</p>')
        id_count += 1
      end
    end.join
  end
  
  def emphasize_word(text, key_word)
    text.gsub!(key_word, "<strong>#{key_word}</strong>") if text.include?(key_word)
    text
  end
end



get "/" do
  @title = "The Adventures of Sherlock Homes"
  erb :home
end


get "/chapters/:number" do
  @num = params[:number].to_i
  @title = "Chapter " + @num.to_s
  @chapter_data = File.read("data/chp" + @num.to_s + ".txt")
  erb :chapter
end

get "/search" do
  @search_term = params[:query]
  @matched_chap_to_paragraphs = {}
  @chapters = match_chapters(@search_term)
  
  @chapters.each do |chapter|
    idx = @toc_data.index(chapter)
    chap_data = File.read("data/chp" + (idx + 1).to_s + ".txt")
    @matched_chap_to_paragraphs[chapter] =  match_paragraphs(chap_data, @search_term)
  end
  
  erb :search
end

not_found do
  redirect "/"
end