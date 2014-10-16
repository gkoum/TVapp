json.array!(@areas) do |area|
  json.extract! area, :scene_id, :number, :place, :dimension, :type
  json.url area_url(area, format: :json)
end