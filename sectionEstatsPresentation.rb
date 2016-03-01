require "net/http"
require "uri"
require 'pry'
require 'json'
require 'CSV'
require_relative 'classes'

@lastmessage = 144752542699067213
@allmessages = []
@messagecounts = []
@groupmembers = []

def stats(id)
  # var =  "https://v2.groupme.com/groups/" + INSERT YOUR GROUP NUMBER HERE + "/messages?before_id=" + id.to_s + "&token=" + INSERT YOUR TOKEN HERE
  var =  "https://v2.groupme.com/groups/" + INSERT YOUR GROUP NUMBER HERE + "/messages?token=" + INSERT YOUR TOKEN HERE
  uri = URI.parse(var)
  response = Net::HTTP.get_response(uri)

  test = JSON.parse(response.body)
  binding.pry

  if test["response"]["messages"][-1]["id"].to_i == 144045784692047258
    @allmessages.flatten
    saveMessagesToCSV

  else
    @lastmessage = test["response"]["messages"][-1]["id"]
    @allmessages << test["response"]["messages"]
    puts @lastmessage
    stats(@lastmessage)
  end
end

def saveMessagesToCSV
  CSV.open("data.csv", "wb") do |csv|

    csv << @allmessages.flatten.first.keys # adds the attributes name on the first line

    @allmessages.flatten.each do |hash|
      csv << hash.values
    end
  end
end

def getMembers
  var =  "https://v2.groupme.com/groups/" + INSERT YOUR GROUP NUMBER HERE + "/messages?token=" + INSERT YOUR TOKEN HERE
  uri = URI.parse(var)
  response = Net::HTTP.get_response(uri)

  test = JSON.parse(response.body)
  members = test["response"]["group"]["memberships"]
  members.each do |member|
    @groupmembers << {:id => member["id"], :name => member["nickname"]}
  end
  saveMembersToCSV
end

def saveMembersToCSV
  CSV.open("members.csv", "wb") do |csv|
      csv << @groupmembers.first.keys # adds the attributes name on the first line
      @groupmembers.each do |hash|
        csv << hash.values
      end
    end
end


def openCSV
  CSV.read('data.csv', :headers => true, :header_converters => :symbol).map {|row| @allmessages << Message.new(row.to_hash)}
  CSV.read('members.csv', :headers => true, :header_converters => :symbol).map {|row| @groupmembers << Member.new(row.to_hash)}
end

def favsfix
  @allmessages.map do |x|
    favs = []
    x.favorited_by.split(/,/).map! do |y|
      favs << y.slice!(2,8).to_i
    end
    x.favorited_by = favs
  end
end

def messagecounts
  count = []
  used = []
  @allmessages.each do |x|
    if used.include? x.name
        count.map do |y|
          if y[0] == x.name
            y[1] += 1
          end
        end
      else
        count << [x.name, 1]
        used << x.name
    end
  end
  count.sort! {|x,y| y[1] <=> x[1]}
  i = 1
  count.each do |x|
    p i.to_s + ") " + x[0] + " - " + x[1].to_s + " posts"
    i += 1
  end
end

def mostpopular
  favcount = []
  favmessages = []
  @allmessages.each do |x|
    favcount << [x.id, x.favorited_by.count]
  end
  favcount.sort! {|x,y| y[1] <=> x[1]}
  test = favcount.slice!(0,10)
  test.each do |x|
    favmessages << @allmessages.find {|y| y.id  == x[0] }
  end

  i = 0
  n = 1
  puts "The most popular posts were:"
  favmessages.each do |x|
    if x.text == nil
      puts n.to_s + ") A picture by: " + x.name + " with " + test[i][1].to_s + " votes and the link of: " + x.picture_url
    else
      puts n.to_s + ") " + x.text + " by: " + x.name + " with " + test[i][1].to_s + " votes"
    end
    puts
    puts
    i += 1
    n += 1
  end

end

def run_it
  openCSV
  favsfix
  messagecounts
  mostpopular
end

# getMembers

# stats(145503304223160963)
run_it
