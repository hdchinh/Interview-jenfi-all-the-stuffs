json.success true
json.set! :data do
  json.array! @train_operators do |train_operator|
    json.call(train_operator, :id, :name, :api_key)
  end
end
