class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_requested = req.path.split("/items/").last
            
            name_of_item = @@items.find {|i| i.name == item_requested}
            
            if name_of_item.nil?
                resp.write "Item not found"
                resp.status = 400
            else
                resp.write name_of_item.price
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end
end