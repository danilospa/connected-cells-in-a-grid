#!/bin/ruby

require 'json'
require 'stringio'

def connected_cells_count(matrix, i, j, scanned_elements)
  return 0 if j == matrix[0].size or i == -1
  return 0 if i == matrix.size or j == -1
  return 0 if matrix[i][j].zero?
  return 0 if scanned_elements[i][j]

  scanned_elements[i][j] = true
  count = 1
  (-1..1).each do |line|
    (-1..1).each do |column|
      next if line == 0 and column == 0
      count += connected_cells_count(matrix, i + line, j + column, scanned_elements)
    end
  end

  count
end

def connected_cell(matrix)
  n = matrix.size
  m = matrix[0].size
  scanned_elements = Array.new(n)
  n.times { |n| scanned_elements[n]= Array.new(m) }

  results = []

  n.times.each do |i|
    m.times.each do |j|
      next if scanned_elements[i][j]
      results << connected_cells_count(matrix, i, j, scanned_elements)
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
