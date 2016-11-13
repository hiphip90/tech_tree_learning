require "#{Rails.root}/app/operations/nodes/create_node"
require "#{Rails.root}/app/operations/nodes/update_node"

class NodesController < ApplicationController
  def show
    @node = Node.find(params[:id])
    respond_to do |format|
      format.json { render :show, layout: false }
    end
  end

  def create
    @tree = Tree.find(params[:tree_id])
    @node = CreateNode.new(@tree, node_params).process
    head :created
  end

  def update
    @node = UpdateNode.new(params[:id], node_params).process
    respond_to do |format|
      format.json { render :show, layout: false }
    end
  end

  def destroy
    @node = Node.find(params[:id])
    @node.destroy
    head :created
  end

  private

  def node_params
    params.require(:node).permit(:full_name, :depth, :column_number, :icon, requirements: [],
                                 learning_materials: [:name, :description])
  end
end
