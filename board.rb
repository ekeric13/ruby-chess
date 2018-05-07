class Board
  def initialize()
    @squareLen = 9
    @boardLen = 8
    @grid = Array.new(@boardLen) { Array.new(@boardLen).fill(EmptyPiece.new('', nil)) }
  end

  def display
    print("\n")
    num_display_rows = (@grid.length*2)+2
    num_display_cols = num_display_rows

    (num_display_rows).times do |row|
      (num_display_cols).times do |col|
        arrRow = (row-1) / 2
        arrCol = (col-1) / 2
        if row == 0
          display_row_index(col, arrCol)
        elsif col == 0
          display_col_index(row, arrRow)
        elsif row % 2 == 1
          display_horizontal_divider          
        elsif col % 2 == 1
          display_vertical_divider          
        else
          display_piece(row, col, arrRow, arrCol)          
        end
      end
      print("\n")
    end
    print("\n")
  end

  def display_row_index(col, arrCol)
    if col == 0 
      print(" ")
    elsif col % 2 == 1
      print('|')
    else
      spacesAfterNum = " " * (@squareLen - 1)
      print(arrCol.to_s + spacesAfterNum)
    end
  end

  def display_col_index(row, arrRow)
    if row % 2 == 1
      print('-'* 5)
    else
      print(arrRow.to_s)
    end  
  end

  def display_horizontal_divider
    print('-'* 5)
  end

  def display_vertical_divider
    print('|')
  end

  def display_piece(row, col, arrRow, arrCol)
    val = @grid[arrRow][arrCol]
    consoleText = val.fullName
    firstCase = (col+2) % 4 == 0 && (row+2) % 4 == 0
    secondCase = col % 4 == 0 && row % 4 == 0
    if firstCase || secondCase
      consoleText = "\e[30m\e[47m#{consoleText}\e[0m"
    end
    print(consoleText)
  end

  def pieceAtLocation(x,y)
    @grid[y] && @grid[y][x]
  end
  def placePieceAt(x,y, piece)
    @grid[y][x] = piece
  end
  def piecesInWay(oldLoc, newLoc)
    oldX, oldY = oldLoc
    newX, newY = newLoc
    distanceX = (newX - oldX).abs()
    distanceY = (newY - oldY).abs()
    if distanceX != 0 && distanceY != 0
      return piecesInWaySlanted(oldLoc, newLoc)
    elsif distanceX != 0
      return piecesInWayHorizontal(oldLoc, newLoc)
    else 
      return piecesInWayVertical(oldLoc, newLoc)
    end
  end
  def calcRange(coordinate1, coordinate2)
    min, max = [coordinate1, coordinate2].minmax
    return (min+1..max-1)
  end
  def piecesInWaySlanted(oldLoc, newLoc)
    oldX, oldY = oldLoc
    newX, newY = newLoc
    xRange = calcRange(oldX, newX)
    yRange = calcRange(oldY, newY)
    for x in xRange
      for y in yRange
        return true if !@grid[y][x].isEmpty
      end
    end
    return false
  end
  def piecesInWayHorizontal(oldLoc, newLoc)
    oldX, oldY = oldLoc
    newX, newY = newLoc
    xRange = calcRange(oldX, newX)
    for x in xRange
      return true if !@grid[oldY][x].isEmpty
    end
    return false
  end
  def piecesInWayVertical(oldLoc, newLoc)
    oldX, oldY = oldLoc
    newX, newY = newLoc
    yRange = calcRange(oldY, newY)
    for y in yRange
      return true if !@grid[y][oldX].isEmpty
    end
    return false
  end
end