class NodesController < ApplicationController
  def create
    @tree = Tree.find(params[:tree_id])
    @node = @tree.nodes.create(node_params)
    head :created
  end

  private

  def node_params
    params.require(:node).permit(:full_name, :depth, :column_number, :icon, requirements: [])
  end
end
