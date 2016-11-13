class UpdateNode
  attr_reader :node, :lm_params
  attr_accessor :old_name

  def initialize(id, params)
    @node = Node.find(id)
    @lm_params = params.delete('learning_materials')
    @node.assign_attributes(params)
  end

  def process
    return false unless node.valid?
    ActiveRecord::Base.transaction do
      _execute_before_update_callbacks
      node.save
      _execute_after_update_callbacks
    end
    execute_on_success_callbacks and return node if node.errors.empty?
  end

  private

  def _execute_before_update_callbacks
    update_name
    create_learning_materials
  end

  def _execute_after_update_callbacks
  end

  def execute_on_success_callbacks
    update_dependent_requirements
  end

  def update_name
    self.old_name = node.name
    node.name = node.full_name.downcase.gsub(' ', '')
  end

  def update_dependent_requirements
    dependent_nodes = node.tree.nodes.where("'#{old_name}' = ANY (requirements)")
    dependent_nodes.each do |dependent_node|
      dependent_node.requirements.delete_if { |req| req == old_name }
      dependent_node.requirements << node.name
      dependent_node.save
    end
  end

  def create_learning_materials
    lm_params.present? && lm_params['name'].present? && lm_params['description'].present?
    lm = LearningMaterial.new(lm_params)
    lm.node = node
    node.learning_materials << lm
  end
end
