json.array!(@scenes) do |scene|
  json.extract! scene, :name, :url
  json.url scene_url(scene, format: :json)
end