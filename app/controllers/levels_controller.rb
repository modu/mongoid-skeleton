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
    @lc = Level.find(:all)
  end

  def load
    ln = params[:id]
    @levelOb = Level.all_of('game.levelName' => ln).first
  end

  def updated
    case params['change']
      when 'new'
        #TODO: ensure that there is no level with the same name
        levelOb = parse(params, $level_spec)
        Level.create(levelOb)
      when 'update'
        levelOb = parse(params, $level_spec)
        Level.where('game.levelName'=>params['levelName']).update_all(levelOb)
      when 'remove'
        Level.where('game.levelName'=>params['levelName']).delete_all()
    end
    render 'index'
  end

  def xml
    ln = params[:id]
    levelOb = Level.all_of('game.levelName' => ln).first
    render :xml => levelOb
  end
  
end
