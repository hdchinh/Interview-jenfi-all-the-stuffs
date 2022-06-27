json.success true
json.set! :data do
  json.array! @trains do |train|
    json.call(train, :id, :max_volume, :max_weight, :cost, :status)
  end
end
