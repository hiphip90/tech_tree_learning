class DashboardController < ApplicationController
  def index
    @tree = Tree.last
  end
end
