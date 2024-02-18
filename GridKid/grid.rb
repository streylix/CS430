class Grid
    def initialize
        @cells = {}
    end

    def set_cell(address, expression)
        @cells[address] = expression
    end

    def get_cell(address)
        @cells.fetch(address) {raise "Cell at address #{address} not found or defined"}
    end
end
