json.nodes @nodes.each do |node|
    json.depth node.depth
    json.image_url node.icon.url
    json.name node.name
    json.requirements node.requirements
end

json.offsets do
    json.frames [{}]
    json.meta meta_hash
end
