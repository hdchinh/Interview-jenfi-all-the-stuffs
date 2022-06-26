json.success true
json.set! :data do
  json.array! @lines do |line|
    json.call(line, :id, :name, :blocked)
  end
end
