# frozen_string_literal: true

class Cell
  attr_accessor :position, :alive_neighbours, :state

  def initialize(state, position, alive_neighbours: 0)
    @state = state
    @position = position
    @alive_neighbours = alive_neighbours
  end

  def live!
    @state = :alive
  end

  def die!
    @state = :dead
  end

  def alive?
    @state == :alive
  end

  def dead?
    !alive?
  end
end
