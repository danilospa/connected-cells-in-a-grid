#!/bin/ruby

require 'json'
require 'stringio'

def next_element(i, j, scanned_elements)
  n = scanned_elements.size
  m = scanned_elements[0].size

  next_i = i + ((j + 1) / m)
  next_j = (j + 1) % m

  return [next_i, next_j] if next_i == n or !scanned_elements[next_i][next_j]
  return next_element(next_i, next_j, scanned_elements)
end

def connected_cells_count(matrix, i, j, scanned_elements)
  return 0 if j == matrix[0].size or i == -1
  return 0 if i == matrix.size or j == -1
  return 0 if scanned_elements[i][j]

  scanned_elements[i][j] = true
  return 0 if matrix[i][j].zero?

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
  scanned_elements = n.times.map { Array.new(m) }

  results = []
  i = 0
  j = 0
  while i != n do
    results << connected_cells_count(matrix, i, j, scanned_elements)
    i, j = next_element(i, j, scanned_elements)
  end

  results.max
end

# Code below was supplied by HackerRank
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
