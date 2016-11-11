json.image_url @node.icon.url
json.full_name @node.full_name
json.depth @node.depth
json.column_number @node.column_number
json.node_url tree_node_url(@node.tree, @node)

json.requirements @node.requirements
json.available_requirements (@node.tree.nodes - [@node]) do |node|
  json.name node.name
  json.full_name node.full_name
end
json.learning_materials @node.learning_materials do |lm|
  json.name lm.name
  json.description lm.description
end
