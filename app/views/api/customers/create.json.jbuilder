json.success true
json.set! :data do
  json.call(@customer, :id, :api_key, :name)
end
