require 'rack'
class FirstApp
    def self.call(env)
        req = Rack::Request.new(env)
        res = Rack::Response.new
        res['Content-Type'] = 'text/html'
        res.write(req.path)
        res.finish
    end
end

# app = Proc.new do |env|
#   req = Rack::Request.new(env)
#   res = Rack::Response.new
#   res['Content-Type'] = 'text/html'
#   res.write("Hello world!")
#   res.finish
# end


Rack::Server.start({
  app: FirstApp,
  Port: 3000
})