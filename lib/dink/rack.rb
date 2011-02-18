# Simply grab the headers out of the request for use later
module Dink
  class Rack
    
    def initialize(app)
      @app = app
    end

    def call(env)
      Dink.sender.user_agent = env["HTTP_USER_AGENT"]
      @app.call(env)
    end
  end
end
