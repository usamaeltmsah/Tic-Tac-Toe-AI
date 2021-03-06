require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def win_childern?(mark)
    children.any? { |child| mark == child.board.winner }
  end

  def losing_node?(evaluator)
    opponent = evaluator == :x ? :o : :x
    return opponent == board.winner if board.over?
    if evaluator == next_mover_mark
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    evaluator == board.winner || win_childern?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []
    (3).times do |i|
      (3).times do |j|
        if @board[[i, j]].nil?
          temp_board = @board.dup
          temp_board[[i, j]] = next_mover_mark
          next_mover_mark = temp_board[[i, j]] == :x ? :o : :x
          children_nodes << TicTacToeNode.new(temp_board, next_mover_mark, [i, j])
        end
      end
    end
    children_nodes
  end
end
