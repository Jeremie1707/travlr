json.array!(@trip_items) do |trip_item|
  json.extract! trip_item, :id, :description
  json.start trip_item.start_date
  json.end trip_item.end_date
  json.title trip_item.name
  json.url "@#{trip_item.id}"
  json.backgroundColor trip_item.category.color
  json.BorderColor trip_item.category.color
end
