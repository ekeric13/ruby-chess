arr = Array.new(8) { Array.new(8).fill("e        ") }
# puts arr.length
for row in (0..(arr.length*2)+1)
  for col in (0..(arr.length*2)+1)
    arrRow = (row-1) / 2
    arrCol = (col-1) / 2
    spaces = " " * 8
    if row == 0
      if col == 0 
        print(" ")
      elsif col % 2 == 1
        print('|')
      else
        print(arrCol.to_s + spaces)
      end
    elsif col == 0
      if row % 2 == 1
        print('-')
      else
        print(arrRow.to_s)
      end      
    elsif row % 2 == 1
      print('-')
    elsif col % 2 == 1
      print('|')
    else             
      val = arr[arrRow][arrCol]
      print(val)
    end
  end
  print("\n")
end

# 1,3