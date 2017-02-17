class NameCollisionError < RuntimeError; end
class NameFormatError < RuntimeError; end

class Robot
  attr_accessor :name

  @registry = []

  def initialize(args = {})
    @registry ||= []
    @name_generator = args[:name_generator] || proc { generate_name }
    @name = @name_generator.call
    check_name
    @registry << @name
  end

  def generate_name
    temp_name = ''
    2.times { temp_name << ('A'..'Z').to_a.sample }
    3.times { temp_name << rand(10).to_s }
    temp_name
  end

  def check_name
    check_name_format
    check_name_collision
  end

  def check_name_format
    return if name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    raise NameFormatError,
      "Robot name: #{name} should be 2 letters and 3 numbers. Ex: AA111"
  end

  def check_name_collision
    return unless @registry.include?(name)
    @name_generator = proc { generate_name }
    @name = @name_generator.call
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
begin
  generator = -> { 'AA111' }
  Robot.new(name_generator: generator)
  Robot.new(name_generator: generator)
rescue => e
  puts "Failed with: #{e.class}: #{e.message}"
end

begin
  generator = -> { 'AA11' }
  Robot.new(name_generator: generator)
rescue => e
  puts "Failed with: #{e.class}: #{e.message}"
end
