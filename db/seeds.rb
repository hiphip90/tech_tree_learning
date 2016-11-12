require "#{Rails.root}/app/operations/nodes/create_node"
tree = Tree.create(name: 'Ruby backend developer', icon: File.new(Rails.root.join('app', 'assets', 'images', "tree.png")))

nodes_data = [
  { "depth" => 0,
    "full_name" => "Fireball acid 2",
    "requirements" => [],
    "column_number" => 3
  },
  { "depth" => 1,
    "full_name" => "Fireball eerie 3",
    "requirements" => [],
    "column_number" => 1
  },
  { "depth" => 2,
    "full_name" => "Light jade 3",
    "requirements" => ["fireballeerie3"],
    "column_number" => 1
  },
  { "depth" => 2,
    "full_name" => "Light royal 3",
    "requirements" => [ "fireballeerie3" ],
    "column_number" => 2
  },
  { "depth" => 1,
    "full_name" => "Fire arrows sky 1",
    "requirements" => [ "fireballacid2" ],
    "column_number" => 3
  },
  { "depth" => 2,
    "full_name" => "Beam blue 2",
    "requirements" => [ "firearrowssky1" ],
    "column_number" => 3
  },
  { "depth" => 1,
    "full_name" => "Needles fire 1",
    "requirements" => [ "fireballacid2" ],
    "column_number" => 5
  },
  { "depth" => 2,
    "full_name" => "Beam red 1",
    "requirements" => [ "needlesfire1", "firearrowssky1" ],
    "column_number" => 4
  },
  { "depth" => 2,
    "full_name" => "Explosion red 3",
    "requirements" => [ "needlesfire1" ],
    "column_number" => 5
  }
]

nodes_data.each do |attributes|
  icon = File.new(Rails.root.join('app', 'assets', 'images', "#{attributes['full_name'].downcase.gsub(' ', '')}.png"))
  attributes.merge!(icon: icon)
  CreateNode.new(tree, attributes).process
end

10.times do |i|
  Tree.create(name: "Test tree ##{i}")
end

node = Node.last
5.times { |i| node.learning_materials.create(name: "line #{i}", description: "line #{i}") }
