json.data do
    json.items do
        json.array!(@schedules) do |schedule|
            json.id schedule.id
            json.user do
                json.name schedule.user.name
                json.image url_for(schedule.user.profile_image)
            end 
            json.image url_for(schedule.image)
            json.title schedule.title
            json.budget schedule.budget
            json.place schedule.place
            json.start_date schedule.start_date
            json.end_date schedule.end_date
            json.schedule_memo schedule.schedule_memo
            json.address schedule.address
            json.latitude schedule.latitude
            json.longitude schedule.longitude
        end
    end 
end
