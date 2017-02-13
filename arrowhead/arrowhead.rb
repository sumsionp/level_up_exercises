class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody",
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow",
    },
  }

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    if CLASSIFICATIONS.include? region
      shapes = CLASSIFICATIONS[region]
      if shapes.include? shape
        arrowhead = shapes[shape]
        "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
      else
        raise "Unknown shape value. Are you sure you know what you're talking about?"
      end
    else
      raise "Unknown region, please provide a valid region."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)

begin
  Arrowhead.classify(:southern_plains, :bifurcated)
rescue => e
  puts "Unknown region raises: #{e.class}: #{e.message}"
end

begin
  Arrowhead.classify(:northern_plains, :plain)
rescue => e
  puts "Unknown shape raises: #{e.class}: #{e.message}"
end
