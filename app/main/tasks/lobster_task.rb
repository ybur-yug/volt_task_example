require 'mechanize'

class LobsterTask < Volt::Task
  def lobsters
    JSON.parse(Mechanize.new.get('https://quiet-temple-1623.herokuapp.com/frontpage/1').content) 
  end
end

