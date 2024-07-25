json.data do
  json.items do
    json.array!(@books) do |book|
      json.id book.id
      json.user do
        json.name book.user.name
        json.image url_for(book.user.profile_image)
      end
      json.image url_for(book.image)
      json.title book.title
      json.address book.address
      json.latitude book.latitude
      json.longitude book.longitude
    end  
  end
end
