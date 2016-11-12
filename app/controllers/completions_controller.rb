class CompletionsController < ApplicationController
  def create
    @node = Node.find(params[:node_id])
    @tree = @node.tree
    @node.complete
    respond_to do |format|
      format.json { render 'nodes/show', layout: false }
    end
  end

  def destroy
    @node = Node.find(params[:node_id])
    @tree = @node.tree
    @node.cancel_completion
    respond_to do |format|
      format.json { render 'nodes/show', layout: false }
    end
  end
end
