
# A cell's "neighbours" are the 8 cells around it.
# If a cell is 'off' but exactly 3 of its neighbours are on, that cell will also turn on - like reproduction.
# If a cell is 'on' but less than two of its neighbours are on, it will die out - like underpopulation.
# If a cell is 'on' but more than three of its neighbours are on, it will die out - like overcrowding.

# grid = []

# grid.each do |cells|
# 	puts cells.inspect
# end

# def neighbors (x,y)
# 	puts grid[x][y]
# end

# neighbors(2,2)

class Board

	def initialize file_name
		@grid = []
		open_file file_name
	end

	def open_file file_name
		File.open(file_name, "r").each_with_index do |line, index|
			@grid << []
			line.split('').each do |cell|
				unless cell == "\n"
					case cell
					when "#"
						is_living = true
					else
						is_living = false
					end
					@grid[index] << Cell.new(is_living)
				end
			end
		end
	end

	def print_baord
		@grid.each do |row|
			puts_friendly_row = ""
			row.each do |cell|
				puts_friendly_row << cell.to_s
			end
			puts puts_friendly_row
		end
	end
end

class Cell
	def initialize is_living
		@is_living = is_living
	end

	def to_s
		return "#" if @is_living
		"."
	end
end

game = Board.new "grid"
game.print_baord
