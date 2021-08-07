class Application

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      # Initialize the below for testing
      #  outside of rspec:
      Item.new("aa", 1.05)
      Item.new("bb", 2.10)
  
      if req.path.match(/items/)
  
        item_name = req.path.split("/items/").last
        item = Item.all.find{|et| et.name == item_name}
        resp.write "#{item.price}" if !!item
  
        resp.status = 400 unless !!item
        resp.write "Item not found" unless !!item
      else
        resp.status = 404
        resp.write "Route not found"
      end
      resp.finish
    end
  end