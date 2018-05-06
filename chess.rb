
=begin
board knows about location of pieces.
player knows about pieces
pieces know about player


game knows about board, player

=end

# each name is 3 + 6

require_relative 'board'
require_relative 'player'

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
      @board.display
      move = askForMove()
      moveHash = @current_player.playMove(@board, move)  

      isValid, message = moveHash.values_at(:valid, :message)
      if !isValid
        puts message
        next
      end
      
      gameDone = checkGameState()
      if gameDone 
        return finishGame()
      end

      @current_player = otherPlayer
    end
  end
  def checkGameState
    !otherPlayer.hasKing
  end

  def parseUserInput(input)
    if input.include? ' '
      return input.split(' ')
    elsif input.include? ','
      return input.split(',')
    else
      return input.split('')
    end
  end
  
  def askForMove
    puts "Your move, #{@current_player.name}"
    puts "Enter the space delimited x y position of piece you want to move"    
    oldInput = gets.chomp
    oldLoc = parseUserInput(oldInput).map{|str| str.to_i }
    puts "Now enter the space delimited x y position of where you want to go"
    newInput = gets.chomp
    newLoc = parseUserInput(newInput).map{|str| str.to_i }
    return [oldLoc, newLoc]
  end
  def finishGame
    @board.display()
    puts "#{@current_player.name} won"
    puts "#{otherPlayer.name} sucks"
    puts "enter y to play again, any other key to exit"
    input = gets.chomp
    if input == "y"
      return startGame()
    else
      exit 0
    end
  end
end

game = Game.new()
game.startGame()


# chess game
# board is a 8x8
# game class
# -players
# -currentPlayer
# -board
# -otherPLayer()
# -startGame()
# --gameState() (create players, player pieces, board, and place pices)
# --render()
# -endGame(winner)
  # print(winner' won')
  # while (userInput !== x || userInput !== y)
   # print(enter y to play again. x to exit)
   # var userInput = ask for input
    #  if userInput == 'y' this.startGame()
    # if userInput == 'x' exit process()
# -render()
    # while(true):
      # printboard
      # this.askForMove()
      # isValid = playMove()
      # if (!isValid) print('not valid'); continue;
      # var state = this.checkGameState()
      # if (state == 'winner') return this.endGame(stae);
      # if (state =='checkmate') print(this.currentPlayer'checkmate'this.otherPlayer)
      # this.playerTurn = this.otherPlayer()

# board class (don't really need)
# player class 
# piece class
# -knight class inherits from
# -biship class inerits from

# start game method on game class
# create 8x8 board
# create 16 player 1 pieces and place on board
# create 16 player 2 pieces and place on board
# asks for player 1 move
# play player 1 move
# check game state
# if victory state say who won. ask if they want to play again. if they do, start game method
# else
# if 1 move away say checkmate
# ask player 2 for their move

# rook (up and down)
# knight (up 2, left 1)
# bishop (diagonal)
# queen (any direction)
# king (one step)
# bishop
# knight
# rook

# board = [
#   ['rook', 'knight', 'bishop', 'queen', 'king', 'bishop', 'knight', 'rook'],
#   ['pawn', 'pawn', 'pawn', 'pawn', 'pawn', 'pawn', 'pawn', 'pawn'],
#   ['','','','','','','',''],
#   ['','','','','','','',''],
#   ['','','','','','','',''],
#   ['','','','','','','',''],
#   ['','','','','','','',''],
#   ['pawn', 'pawn', 'pawn', 'pawn', 'pawn', 'pawn', 'pawn', 'pawn'],
#   ['rook', 'knight', 'bishop', 'queen', 'king', 'bishop', 'knight', 'rook']
# ]
