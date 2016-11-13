class CreateNode
  attr_reader :node, :tree, :lm_params

  def initialize(tree, params)
    @tree = tree
    @lm_params = params.delete('learning_materials')
    @node = @tree.nodes.new(params)
  end

  def process
    return false unless node.valid?
    ActiveRecord::Base.transaction do
      _execute_before_save_callbacks
      node.save
      _execute_after_save_callbacks
    end
    execute_on_success_callbacks and return node if node.persisted?
  end

  private

  def _execute_before_save_callbacks
    populate_name
    create_learning_materials
  end

  def _execute_after_save_callbacks
  end

  def execute_on_success_callbacks
  end

  def populate_name
    node.name = node.full_name.downcase.gsub(' ', '')
  end

  def create_learning_materials
    return unless lm_params.present? && lm_params['name'].present? && lm_params['description'].present?
    lm = LearningMaterial.new(lm_params)
    lm.node = node
    node.learning_materials << lm
  end
end
