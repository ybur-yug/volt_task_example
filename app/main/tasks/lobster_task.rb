require 'mechanize'

class LobsterTask < Volt::Task
  def lobsters
    JSON.parse(Mechanize.new.get('http://localhost:4567/frontpage/1').content) 
  end
end

