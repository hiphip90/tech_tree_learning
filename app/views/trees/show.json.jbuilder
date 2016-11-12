json.nodes @nodes.each do |node|
    json.node_url tree_node_path(@tree, node)
    json.depth node.depth
    json.image_url node.icon.url
    json.name node.name
    json.columnNumber node.column_number
    json.requirements node.requirements
    json.completed node.completed
    json.selected node.completed
end

json.offsets do
    json.frames [{}]
    json.meta meta_hash
end
