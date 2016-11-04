class TreesController < ApplicationController
  def show
    respond_to do |format|
      format.json { render :show, layout: false }
    end
  end
end
