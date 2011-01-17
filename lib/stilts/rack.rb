# Simply grab the headers out of the request for use later
module Stilts
  class Rack
    
    def initialize(app)
      @app = app
    end

    def call(env)
      Stilts.sender.user_agent = env["HTTP_USER_AGENT"]
      @app.call(env)
    end
  end
end
