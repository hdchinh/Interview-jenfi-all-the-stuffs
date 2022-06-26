json.success true
json.set! :data do
  json.call(@train_operator, :id, :api_key, :name)
end
