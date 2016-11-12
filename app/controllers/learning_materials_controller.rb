class LearningMaterialsController < ApplicationController
  def destroy
    lm = LearningMaterial.find(params[:id])
    lm.destroy
    head :created
  end
end
