# frozen_string_literal: true

class Board
  def draw(matrix)
    matrix.each_with_index do |row, row_index|
      row.each_with_index do |_column, column_index|
        print "#{matrix[row_index][column_index]} "
      end
      puts
    end
  end
end
