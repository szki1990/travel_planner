json.data do
  json.items do
    json.array!(@schedules) do |schedule|
      json.title schedule.title
      json.latitude schedule.latitude
      json.longitude schedule.longitude
    end  
  end
end
