require_relative "grid"
class Runtime
    attr_accessor :grid

    def initialize
        @grid = Grid.new
    end
end