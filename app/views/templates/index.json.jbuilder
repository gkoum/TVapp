json.array!(@templates) do |template|
  json.extract! template, :name, :description, :number_of_areas, :number_of_posts
  json.url template_url(template, format: :json)
end