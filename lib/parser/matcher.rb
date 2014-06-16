class Matcher
  attr_reader :section

  def initialize(section)
    @section = section
  end

  def get_value_for(field)
    section.each do |line|
      return line.split(":").last.strip if line.match(Regexp.new(field))
    end
    nil
  end
  
  def get_account_numbers(type)
    get_value_for(type).split(":").last.strip.split("/").map!(&:strip)
  end
end
