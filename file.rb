#!/bin/ruby

require 'json'
require 'stringio'

def not_in_region?(current_region_elements, i, j)
  current_region_elements.detect { |e| e[0] == i and e[1] == j }.nil?
end

def connected_cells_count(matrix, i, j, current_region_elements = [])
  return 0 if j == matrix[0].size or i == -1
  return 0 if i == matrix.size or j == -1
  return 0 if matrix[i][j].zero?
  return 0 unless not_in_region?(current_region_elements, i, j)

  count = 1
  current_region_elements << [i, j]
  count += connected_cells_count(matrix, i, j + 1, current_region_elements)
  count += connected_cells_count(matrix, i + 1, j + 1, current_region_elements)
  count += connected_cells_count(matrix, i + 1, j, current_region_elements)
  count += connected_cells_count(matrix, i + 1, j - 1, current_region_elements)
  count += connected_cells_count(matrix, i, j - 1, current_region_elements)
  count += connected_cells_count(matrix, i - 1, j - 1, current_region_elements)
  count += connected_cells_count(matrix, i - 1, j, current_region_elements)
  count += connected_cells_count(matrix, i - 1, j + 1, current_region_elements)
end

def connected_cell(matrix)
  results = []
  matrix.size.times.each do |i|
    matrix[i].size.times.each do |j|
      results << connected_cells_count(matrix, i, j)
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
