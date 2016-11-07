module NodesHelper
  def requirements_for_select(tree, excluded_node)
    (tree.nodes - [excluded_node]).map { |node| [node.name, node.name] }
  end
end
