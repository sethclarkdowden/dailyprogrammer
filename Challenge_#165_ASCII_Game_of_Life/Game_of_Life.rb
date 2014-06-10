
# A cell's "neighbours" are the 8 cells around it.
# If a cell is 'off' but exactly 3 of its neighbours are on, that cell will also turn on - like reproduction.
# If a cell is 'on' but less than two of its neighbours are on, it will die out - like underpopulation.
# If a cell is 'on' but more than three of its neighbours are on, it will die out - like overcrowding.

iterations = 7
file_name = "grid"


class Board

	def initialize file_name
		@grid = []
		open_file file_name
	end

	def update_grid newgrid 
		@grid =  newgrid
	end

	def grid 
		@grid
	end

	def open_file file_name
		File.open(file_name, "r").each_with_index do |line, index|
			@grid << []
			@width = line.split('').count - 1 
			@height = index
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
		puts "Width: #{@width}  Height: #{@height}"
	end

	def neighbours x, y 
		neighbours = []
		neighbours << @grid[up(y)][left(x)]
		neighbours << @grid[up(y)][x]
		neighbours << @grid[up(y)][right(x)]
		neighbours << @grid[y][left(x)]
		neighbours << @grid[y][right(x)]
		neighbours << @grid[down(y)][left(x)]
		neighbours << @grid[down(y)][x]
		neighbours << @grid[down(y)][right(x)]
		neighbours
	end

	def up cell 
		if (cell - 1) < 0 
			@height
		else 
			cell - 1
		end
	end

	def down cell
		if (cell + 1) > @height
			0
		else 
			cell + 1
		end
	end

	def left cell
		if (cell - 1) < 0
			@width
		else 
			cell -1 
		end
	end

	def right cell
		if (cell + 1) > @width
			0
		else 
			cell + 1
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

class Play
	def initialize game, iterations
		@game = game
		@iterations = iterations
		run
	end

	def run
		@iterations.times do |n|
			newgrid = []
			@game.grid.each_with_index do |row, y|
				newrow = []
				row.each_with_index do |cell, x|
					newrow << logic(cell, @game.neighbours(x,y))
				end
				newgrid << newrow
			end
			@game.update_grid(newgrid)
			@game.print_baord
			puts "iteration: ##{n}"
		end
	end

	def logic cell, neighbours
		if cell.to_s == "." && 3 == neighbours.count { |cell| cell.to_s == "#" } 
			Cell.new(is_living = true)
		elsif cell.to_s == "#" && 2 > neighbours.count { |cell| cell.to_s == "#" }
			Cell.new(is_living = false)
		elsif cell.to_s == "#" && 3 < neighbours.count { |cell| cell.to_s == "#" }
			Cell.new(is_living = false)
		else
			cell
		end
	end
end

game = Board.new file_name
Play.new(game, iterations + 1)
