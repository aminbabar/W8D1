require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    # debugger
    @req = req
    @res = Rack::Response.new

    @cookie = req.cookies["_rails_lite_app"]
    
    if @cookie
      @cookie.value = JSON.parse(@cookie)
    else
      # req.cookies["_rails_lite_app"] = 
      @res.set_cookie("_rails_lite_app", {path: "/", value: ""})
    end

  end

  def [](key)
  end

  def []=(key, val)
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
  end
end
