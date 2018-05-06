class Test
  def hey
    v = c
  end


class Player
  attr_accessor :name
  def initialize(name, id)
    @name = name
    @id = id
  end
  def placePieces(x)
    puts @name
  end
end

class Board
  def display
  end
end

class Game
  def initialize()
    @board
    @current_player
    @players
  end
  def startGame()
    createGameState()
    gameLoop()
  end
  def createGameState()
    player1 = Player.new('p1', 7)
    player2 = Player.new('p2', 0)
    @players = [player1, player2]
    @current_player = player1
    @board = Board.new()
    player1.placePieces(@board)
    player2.placePieces(@board)
  end
  def otherPlayer
    if @current_player == @players[0]
      return @players[1]
    end
    return @players[0]
  end
  def gameLoop()
    while true
      @board.display()

      move = askForMove()
      # moveHash = currentPlayer.playMove(board, move)
      # isValid, message = moveHash.values(:isValid, :message)
      # if !isValid
      #   puts message
      #   next
      # end
      
      # gameDone = this.checkGameState()
      # if gameDone 
      #   return finishGame()
      # end

      # @current_player = otherPlayer
    end
  end
  def checkGameState
    !otherPlayer.hasKing
  end
  def askForMove
    @current_player.name = '20'
    puts "Your move, #{@current_player.name}"
    puts "Enter the space delimited position of piece you want to move"
    oldLoc = gets.chomp
    puts "Now enter the space delimited position of where you want to go"
    newLoc = gets.chomp
    return [oldLoc, newLoc]
  end
  def finishGame
    @board.display()
    puts "#{@current_player.name} won"
  end
end

game = Game.new()
game.startGame()