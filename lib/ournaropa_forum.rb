# requires all dependencies
Gem.loaded_specs['ournaropa_forum'].dependencies.each do |d|
 require d.name
end

require "ournaropa_forum/engine"

module OurnaropaForum
end
