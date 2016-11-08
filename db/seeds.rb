tree = Tree.create(name: 'rpg')

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
  node = Node.create(attributes.merge(tree: tree, icon: icon))
end
