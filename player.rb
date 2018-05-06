require_relative 'pieces'

class Player
  attr_reader :name, :startOfBoardIndex
  attr_accessor :numPawnsPlaced, :numRooksPlaced, :numKnightsPlaced, :numBishopsPlaced
  def initialize(name, startOfBoardIndex)
    @name = name
    @startOfBoardIndex = startOfBoardIndex
    @pieces = createPieces()
    @numPawnsPlaced = 0
    @numRooksPlaced = 0
    @numKnightsPlaced = 0
    @numBishopsPlaced = 0
  end

  def createPieces()
    pieces = []
    pieces.push(King.new('king  ', self))
    pieces.push(Queen.new('queen ', self))
    for pawn in (0..7)
      pieces.push(Pawn.new('pawn  ', self))
    end
    for rook in (0..1)
      pieces.push(Rook.new('rook  ', self))
    end
    for knight in (0..1)
      pieces.push(Knight.new('knight', self))
    end
    for bishop in (0..1)
      pieces.push(Bishop.new('bishop', self))
    end
    return pieces
  end

  def endOfBoardIndex
    startOfBoardIndex == 0 ? 7 : 0
  end

  def placePieces(board)
    @pieces.each do |piece|
      x, y = piece.startingPosition()
      board.placePieceAt(x, y, piece) 
    end
  end

  def hasKing()
    @pieces.any? {|piece| piece.isKing}
  end

  def removePiece(piece)
    @pieces = @pieces.drop_while do |pieceInstance|
      pieceInstance == piece
    end
  end

  def replacePieceForQueen(piece)
    removePiece(piece)
    @pieces.push(Queen.new('queen ', self))
  end

  def pieceBelongsToPlayer(piece)
    self == piece.owner
  end

  def pieceBelongsToOtherPlayer(piece)
    piece.owner && piece.owner != self
  end

  def playMove(board, move)
    oldLoc, newLoc = move 
    oldX, oldY = oldLoc
    newX, newY = newLoc
    movingPiece = board.pieceAtLocation(oldX,oldY)
    return {valid: false, message: 'you have to move a real piece'} if !movingPiece 
    if !pieceBelongsToPlayer(movingPiece)
      return {valid: false, message: 'you have to move one of your own pieces'}  
    end
      
    killedPiece = board.pieceAtLocation(newX, newY)
    return {valid: false, message: 'location moving to not on board'} if !killedPiece 
    
    validMove = true
    if movingPiece.isPawn
      goingToKillOtherPlayer = pieceBelongsToOtherPlayer(killedPiece)
      validMove = movingPiece.validMoveType(oldLoc, newLoc, goingToKillOtherPlayer)
    else
      validMove = movingPiece.validMoveType(oldLoc, newLoc)
    end

    if !validMove
      return {valid: false, message: "cannot move #{movingPiece.name.strip} to #{newX}, #{newY}" }
    end
    
    return {valid: false, message: 'cannot overlap pieces'} if pieceBelongsToPlayer(killedPiece) 
    
    # knights can skip
    if !movingPiece.isKnight && board.piecesInWay(oldLoc, newLoc) 
      return {valid: false, message: 'cannot jump over pieces'}
    end
    board.placePieceAt(oldX, oldY, EmptyPiece.new())
    board.placePieceAt(newX, newY, movingPiece)
    killedPiece.remove()
    movingPiece.timesMoved += 1

    # checkIfPawnReachedEndOfBoard
    if (newY == endOfBoardIndex && movingPiece.isPawn)
      replacePieceForQueen(movingPiece)
    end
    return {valid: true}
  end
end