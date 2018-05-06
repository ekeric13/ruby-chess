class BasePiece
  attr_reader :name, :owner
  attr_accessor :timesMoved
  def initialize(name = '', owner = nil)
    @name = name
    @owner = owner
    @timesMoved = 0
  end
  def validMoveTypeCalculation(oldLoc, newLoc)
    oldX, oldY = oldLoc
    newX, newY = newLoc
    return [(newX-oldX).abs(), (newY-oldY).abs()]
  end
  def validMoveType(x=nil, y=nil, z=nil)
    true
  end
  def remove
    @owner.removePiece(self)
  end
  def fullName
    @owner.name + "-" + @name.capitalize
  end
  def isKnight
    false
  end
  def isEmpty
    false
  end
  def isKing
    false
  end
  def isPawn
    false
  end
end

class EmptyPiece < BasePiece
  def remove
    nil
  end
  def fullName
    emptyStr = ' ' * 9    
  end
  def isEmpty
    true
  end
end

class Pawn < BasePiece
  def validMoveType(oldLoc, newLoc, killingOtherPlayer)
    x, y = validMoveTypeCalculation(oldLoc, newLoc)
    attackMove = x == 1 && y == 1
    if killingOtherPlayer
      return attackMove
    elsif @timesMoved == 0
      return x == 0 && (y == 1 || y == 2)
    else 
      return x == 0 && y == 1
    end
  end
  def startingPosition
    x = @owner.numPawnsPlaced
    startOfBoardIndex = @owner.startOfBoardIndex
    y = startOfBoardIndex == 0 ? startOfBoardIndex + 1: startOfBoardIndex - 1
    @owner.numPawnsPlaced += 1
    return [x, y]
  end
  def isPawn
    true
  end
end

class Rook < BasePiece
  def validMoveType(oldLoc, newLoc)
    x, y = validMoveTypeCalculation(oldLoc, newLoc)
    return (x > 0 && y == 0) || (y > 0 && x == 0)
  end
  def startingPosition
    x = @owner.numRooksPlaced == 0 ? 0 : 7
    y = @owner.startOfBoardIndex
    @owner.numRooksPlaced += 1
    return [x, y]
  end
end

class Knight < BasePiece
  def validMoveType(oldLoc, newLoc)
    x, y = validMoveTypeCalculation(oldLoc, newLoc)
    return (x == 2 && y == 1) || (x == 1 && y == 2)
  end
  def startingPosition
    x = @owner.numKnightsPlaced == 0 ? 1 : 6
    y = @owner.startOfBoardIndex
    @owner.numKnightsPlaced += 1
    return [x, y]
  end
  def isKnight
    true
  end
end

class Bishop < BasePiece
  def validMoveType(oldLoc, newLoc)
    x, y = validMoveTypeCalculation(oldLoc, newLoc)
    return x == y && x > 0
  end
  def startingPosition
    x = @owner.numBishopsPlaced == 0 ? 2 : 5
    y = @owner.startOfBoardIndex
    @owner.numBishopsPlaced += 1
    return [x, y]
  end
end

class Queen < BasePiece
  def validMoveType(oldLoc, newLoc)
    x, y = validMoveTypeCalculation(oldLoc, newLoc)
    rookMovementPattern = (x > 0 && y == 0) || (y > 0 && x == 0)
    bishopMovementPattern = (x == y && x > 0)
    return rookMovementPattern || bishopMovementPattern
  end
  def startingPosition
    x = 3
    y = @owner.startOfBoardIndex
    return [x, y]
  end
end

class King < BasePiece
  def validMoveType(oldLoc, newLoc)
    x, y = validMoveTypeCalculation(oldLoc, newLoc)
    return (x == 1 && y == 0) || (x == 0 && y == 1) || (x == 1 && y == 1) 
  end
  def startingPosition
    x = 4
    y = @owner.startOfBoardIndex
    return [x, y]
  end
  def isKing
    true
  end
end