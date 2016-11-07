class DashboardController < ApplicationController
  def index
    @tree = Tree.last
    @node = @tree.nodes.new
  end
end
