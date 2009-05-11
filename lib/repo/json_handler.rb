class Repo::JSONHandler
  def read(data)
    JSON.load(data)
  end

  def write(data)
    data.to_json
  end    
end
