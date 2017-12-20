class GopayUpdateConsumer < Racecar::Consumer
  subscribes_to "gopay-update"

  def process(message)
    puts "Received message: #{message.value}"
    user_attributes = JSON.parse(message.value)
    user = User.find(user_attributes["id"])
    user.gopay_balance = user_attributes["gopay_balance"]
    user.save
  end
end
