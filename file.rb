#!/bin/ruby

require 'json'
require 'stringio'

def not_in_region?(current_region_elements, i, j)
  current_region_elements.detect { |e| e[0] == i and e[1] == j }.nil?
end

def connect_cells(matrix, i, j, current_region_elements = [])
  return if j == matrix[0].size or i == -1
  return if i == matrix.size or j == -1
  return if matrix[i][j].zero?
  return unless not_in_region?(current_region_elements, i, j)

  current_region_elements << [i, j]
  connect_cells(matrix, i, j + 1, current_region_elements)
  connect_cells(matrix, i + 1, j + 1, current_region_elements)
  connect_cells(matrix, i + 1, j, current_region_elements)
  connect_cells(matrix, i + 1, j - 1, current_region_elements)
  connect_cells(matrix, i, j - 1, current_region_elements)
  connect_cells(matrix, i - 1, j - 1, current_region_elements)
  connect_cells(matrix, i - 1, j, current_region_elements)
  connect_cells(matrix, i - 1, j + 1, current_region_elements)
end

def connected_cell(matrix)
  scanned_elements = []
  max = 0
  matrix.size.times.each do |i|
    matrix[i].size.times.each do |j|
      next unless not_in_region?(scanned_elements, i, j)
      region_elements = []
      connect_cells(matrix, i, j, region_elements)
      scanned_elements.concat(region_elements)
      max = region_elements.size if region_elements.size > max
    end
  end

  max
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
