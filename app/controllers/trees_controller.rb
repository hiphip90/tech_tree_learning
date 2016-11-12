class TreesController < ApplicationController
  def index
    @trees = Tree.all
  end

  def create
    Tree.create(tree_params)
    redirect_to root_path
  end

  def show
    @tree = Tree.find(params[:id])
    @nodes = @tree.nodes
    @node = @nodes.first
    respond_to do |format|
      format.json { render :show, layout: false }
      format.html
    end
  end

  def edit
    @tree = Tree.find(params[:id])
    @nodes = @tree.nodes
    @node = @tree.nodes.new
    @new_lm = @node.learning_materials.build
  end

  def destroy
    @tree = Tree.find(params[:id])
    @tree.destroy
    redirect_to root_path
  end

  private

  def tree_params
    params.require(:tree).permit(:name, :icon)
  end
end
