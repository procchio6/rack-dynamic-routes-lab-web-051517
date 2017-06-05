class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item = req.path.split("/items/").last
      item_price = get_item_price(item)
      if item_price
        resp.write item_price
        resp.status = 200
      else
        resp.write "Item not found."
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

  def get_item_price(searched_item)
    response = nil
    @@items.each do |item|
      if item.name == searched_item
        response = item.price
      end
    end
    response
  end

end
