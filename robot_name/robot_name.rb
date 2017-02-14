class NameCollisionError < RuntimeError; end
class NameFormatError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call
    else
      @name = generate_name
    end

    check_name_format
    check_name_collision
    @@registry << @name
  end

  def generate_name
    temp_name = ''
    2.times { temp_name << ('A'..'Z').to_a.sample }
    3.times { temp_name << rand(10).to_s }
    temp_name
  end

  def check_name_format
    unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
      raise NameFormatError,
        'Robot name should be 2 letters and 3 numbers. Ex: AA111'
    end
  end

  def check_name_collision
    if @@registry.include?(name)
      raise NameCollisionError,
        'Robot name is already in the registry'
    end
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
