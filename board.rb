class Board
  def initialize()
    @squareLen = 9
    @boardLen = 8
    @grid = Array.new(@boardLen) { Array.new(@boardLen).fill(EmptyPiece.new()) }
  end

  def display
    print("\n")
    arr = @grid
    for row in (0..(arr.length*2)+1)
      for col in (0..(arr.length*2)+1)
        arrRow = (row-1) / 2
        arrCol = (col-1) / 2
        spacesAfterNum = " " * (@squareLen - 1)
        if row == 0
          if col == 0 
            print(" ")
          elsif col % 2 == 1
            print('|')
          else
            print(arrCol.to_s + spacesAfterNum)
          end
        elsif col == 0
          if row % 2 == 1
            print('-'* 5)
          else
            print(arrRow.to_s)
          end      
        elsif row % 2 == 1
          print('-'* 5)
        elsif col % 2 == 1
          print('|')
        else             
          val = arr[arrRow][arrCol]
          consoleText = val.fullName
          firstCase = (col+2) % 4 == 0 && (row+2) % 4 == 0
          secondCase = col % 4 == 0 && row % 4 == 0
          if firstCase || secondCase
            consoleText = "\e[30m\e[47m#{consoleText}\e[0m"
          end
          print(consoleText)
        end
      end
      print("\n")
    end
    print("\n")
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