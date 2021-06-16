# frozen_string_literal: true

require_relative './reader'
require_relative './board'
require_relative './cell'

class Grid
  def plain_matrix
    cell_data = Reader.new.read_file
    rows = cell_data.length
    columns = cell_data[0].length
    plain_cell_matrix = Array.new(rows) { Array.new(columns) }
    cell_data.each_with_index do |row, row_index|
      row.each_char.with_index do |plain_cell, column_index|
        plain_cell_matrix[row_index][column_index] = plain_cell
      end
    end
    plain_cell_matrix
  end

  def object_matrix
    rows = plain_matrix.length
    columns = plain_matrix[0].length
    cell_matrix = Array.new(rows) { Array.new(columns) }
    plain_matrix.each_with_index do |row, row_index|
      row.each_with_index do |plain_cell, column_index|
        cell_matrix[row_index][column_index] = create_cell(plain_cell, row_index, column_index)
      end
    end
    cell_matrix
  end

  def draw_board
    Board.new.draw(plain_matrix)
  end

  def assign_position(row_index, column_index)
    { x: row_index, y: column_index }
  end

  def assign_state(plain_cell)
    plain_cell == '*' ? :alive : :dead
  end

  def create_cell(plain_cell, row_index, column_index)
    state = assign_state(plain_cell)
    position = assign_position(row_index, column_index)
    Cell.new(state, position)
  end

  def neighbour_positions(x, y)
    [
      [x - 1, y - 1],
      [x - 1, y],
      [x - 1, y + 1],
      [x, y - 1],
      [x, y + 1],
      [x + 1, y - 1],
      [x + 1, y],
      [x + 1, y + 1]
    ]
  end

  def on_board?(x_pos, y_pos)
    rows = plain_matrix.length
    columns = plain_matrix[0].length
    x_pos_on_board = (x_pos >= 0) && (x_pos < rows)
    y_pos_on_board = (y_pos >= 0) && (y_pos < columns)
    x_pos_on_board && y_pos_on_board
  end

  def check_alive_neigbours(cell)
    alive_neighbours = 0
    neighbours = neighbour_positions(cell.position[:x], cell.position[:y])
    neighbours.each do |x, y|
      alive_neighbours += 1 if on_board?(x, y) && object_matrix[x][y].alive?
    end
    alive_neighbours
  end

  def next_generation
    first_generation = object_matrix
    first_generation.map do |row|
      row.map do |cell|
        cell.alive_neighbours = check_alive_neigbours(cell)
      end
    end
    first_generation.map do |row|
      row.map do |cell|
        cell.live! if cell.alive? && (cell.alive_neighbours == 3 || cell.alive_neighbours == 2)
        cell.kill! if cell.alive? && (cell.alive_neighbours < 2 || cell.alive_neighbours > 3)
        cell.live! if cell.dead? && cell.alive_neighbours == 3
      end
    end
    show_next_generation(first_generation)
  end

  def show_next_generation(generation)
    generation.each do |row|
      row.each do |cell|
        print cell.alive? ? '*' : '.'
      end
      puts
    end
  end
end
