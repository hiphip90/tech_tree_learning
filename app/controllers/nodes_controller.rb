class NodesController < ApplicationController
  def create
    @tree = Tree.find(params[:tree_id])
    @node = @tree.nodes.create(node_params)
    render "dashboard/index"
  end

  private

  def node_params
    params.require(:node).permit(:name, :depth, :column_number, :icon, requirements: [])
  end
end
