class CreateNode
  attr_reader :node, :tree

  def initialize(tree, params)
    @tree = tree
    @node = @tree.nodes.new(params)
    sanitize
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
  end

  def _execute_after_save_callbacks
  end

  def execute_on_success_callbacks
  end

  def populate_name
    node.name = node.full_name.downcase.gsub(' ', '')
  end

  def sanitize
    node.requirements.reject(&:blank?)
    node.learning_materials.each do |lm|
      next if lm.valid?
      lm.destroy
    end
  end
end
