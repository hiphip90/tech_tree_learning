class NodesController < ApplicationController
  def show
    @node = Node.find(params[:id])
    respond_to do |format|
      format.json { render :show, layout: false }
    end
  end

  def create
    @tree = Tree.find(params[:tree_id])
    @node = @tree.nodes.create(node_params)
    head :created
  end

  def destroy
    @node = Node.find(params[:id])
    @node.destroy
    head :created
  end

  private

  def node_params
    params.require(:node).permit(:full_name, :depth, :column_number, :icon, requirements: [])
  end
end
