class LevelsController < ApplicationController
  def index
  end

  def create
  end

  def created
    levelOb = parse(params, $level_spec)
    Level.create(levelOb)
    render 'index'
  end

  def show
  end

  def load
  end

  def updated
  end

  def xml
  end

end
