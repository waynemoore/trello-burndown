require 'trello'

if ENV['TRELLO_API_KEY'].nil? || ENV['TRELLO_API_MEMBER_TOKEN'].nil?
  raise 'API Keys seem to be missing'
end

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_API_KEY']
  config.member_token = ENV['TRELLO_API_MEMBER_TOKEN']
end

def parse_points(title)
  (title.match(/(\d+)/) || '0')[0].to_i
end

board = Trello::Board.find('VAO70dxZ') # biz kanban
lists = board.lists

total = 0
done = 0
todo = 0

lists.each do |list|
  cards = list.cards

  cards.each do |card|
    points = parse_points(card.name)
    total += points

    if list.name == 'Done'
      done += points
    else
      todo += points
    end
  end
end

puts "total: #{total}"
puts "todo: #{todo}"
puts "done: #{done}"

