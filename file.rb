#!/bin/ruby

require 'json'
require 'stringio'

def not_in_region?(current_region_elements, i, j)
  current_region_elements.detect { |e| e[0] == i and e[1] == j }.nil?
end

def connected_cells_count(matrix, i, j, current_region_elements)
  count = 1
  if (j + 1 < matrix[0].size and matrix[i][j + 1] == 1 and not_in_region?(current_region_elements, i, j + 1))
    current_region_elements << [i, j + 1]
    count += connected_cells_count(matrix, i, j + 1, current_region_elements)
  end

  if (i + 1 < matrix.size and matrix[i + 1][j] == 1 and not_in_region?(current_region_elements, i + 1, j))
    current_region_elements << [i + 1, j]
    count += connected_cells_count(matrix, i + 1, j, current_region_elements)
  end

  if (i + 1 < matrix.size and j + 1 < matrix[0].size and matrix[i + 1][j + 1] == 1 and not_in_region?(current_region_elements, i + 1, j + 1))
    current_region_elements << [i + 1, j + 1]
    count += connected_cells_count(matrix, i + 1, j + 1, current_region_elements)
  end

  count
end

def connected_cell(matrix)
  results = []
  matrix.size.times.each do |i|
    matrix.size.times.each do |j|
      next if matrix[i][j].zero?
      results << connected_cells_count(matrix, i, j, [[i, j]])
    end
  end

  results.max
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

n = gets.to_i

gets.to_i

matrix = Array.new(n)

n.times do |i|
    matrix[i] = gets.rstrip.split(' ').map(&:to_i)
end

result = connected_cell matrix

fptr.write result
fptr.write "\n"

fptr.close()
