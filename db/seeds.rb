tree = Tree.create(name: 'rpg')

nodes_data = [
  { "depth" => 0,
    "name" => "fireball-acid-2",
    "requirements" => []
  },
  { "depth" => 1,
    "name" => "fireball-eerie-3",
    "requirements" => []
  },
  { "depth" => 2,
    "name" => "light-jade-3",
    "requirements" => ["fireball-eerie-3"]
  },
  { "depth" => 2,
    "name" => "light-royal-3",
    "requirements" => [ "fireball-eerie-3" ]
  },
  { "depth" => 1,
    "name" => "fire-arrows-sky-1",
    "requirements" => [ "fireball-acid-2" ]
  },
  { "depth" => 2,
    "name" => "beam-blue-2",
    "requirements" => [ "fire-arrows-sky-1" ]
  },
  { "depth" => 2,
    "name" => "wind-blue-1",
    "requirements" => [ "fire-arrows-sky-1",
                       "needles-fire-1" ]
  },
  { "depth" => 1,
    "name" => "needles-fire-1",
    "requirements" => [ "fireball-acid-2" ]
  },
  { "depth" => 2,
    "name" => "beam-red-1",
    "requirements" => [ "needles-fire-1" ]
  },
  { "depth" => 2,
    "name" => "explosion-red-3",
    "requirements" => [ "needles-fire-1" ]
  }
]

nodes_data.each do |attributes|
  icon = File.new(Rails.root.join('app', 'assets', 'images', "#{attributes['name']}.png"))
  Node.create(attributes.merge(tree: tree, icon: icon))
end
