
def print_grid(grid)
  grid.each do |key, value|
    value.each { |hole| print "|#{hole}"}
    print "\n"
  end
end

print_grid(grid)
# add color
# proper TDD
