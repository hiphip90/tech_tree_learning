class TreesController < ApplicationController
  def show
    @nodes = Tree.find(params[:id]).nodes
    respond_to do |format|
      format.json { render :show, layout: false }
    end
  end
end
