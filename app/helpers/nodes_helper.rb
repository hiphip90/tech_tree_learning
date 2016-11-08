module NodesHelper
  def requirements_for_select(tree, excluded_node)
    (tree.nodes - [excluded_node]).map { |node| [node.full_name, node.name] }
  end
end
