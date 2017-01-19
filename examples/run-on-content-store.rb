require 'yaml'
paths = []

ContentItem.distinct(:rendering_app).each do |rendering_app|
  coll = ContentItem.where(rendering_app: rendering_app)
  coll.skip(rand(coll.count)).limit(20).each do |content_item|
    paths << content_item['base_path']
  end
end

puts YAML.dump(paths)
