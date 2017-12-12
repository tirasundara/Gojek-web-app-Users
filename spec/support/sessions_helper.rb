module SessionsHelpers

  def log_in_as(user)
    session[:user_id] = user.id
  end
end

RSpec.configure do |c|
  c.include SessionsHelpers
end
