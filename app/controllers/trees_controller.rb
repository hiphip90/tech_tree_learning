class TreesController < ApplicationController
  def index
    @trees = Tree.all
  end

  def show
    @tree = Tree.find(params[:id])
    @nodes = @tree.nodes
    respond_to do |format|
      format.json { render :show, layout: false }
      format.html
    end
  end

  def edit
    @tree = Tree.find(params[:id])
    @nodes = @tree.nodes
    @node = @tree.nodes.new
  end
end
