require 'set'

class MonkeyGrid
  @@limit = 19

  def initialize
    @locations = Set.new
    @tried = Set.new
    @q = []
  end

  def sum_digits n
    n.abs.to_s.split(//).map(&:to_i).inject(:+)
  end

  def accessible x, y
    sum = sum_digits(x) + sum_digits(y)
    return sum <= @@limit
  end

  def locations
    @locations
  end

  def try x, y
    @q.push [x, y] if accessible x, y and not @locations.include? [x, y] and not @tried.include? [x, y]
    @tried.add [x, y]
  end

  def walk x, y
    @q.push [x, y] if accessible x, y

    while not @q.empty?
      cell = @q.shift
      x, y = cell[0], cell[1]

      @locations.add [x, y]

      try x + 1, y
      try x, y + 1
      try x - 1, y
      try x, y - 1
    end
  end
end

g = MonkeyGrid.new
g.walk 0, 0

print g.locations.count