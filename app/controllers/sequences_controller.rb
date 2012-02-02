class SequencesController < ApplicationController
  def index
  end

  def create
    inp = Level.only('game.levelName').entries
    @levelNames = []
    inp.each do |i|
      @levelNames << i[:game]['levelName']
    end
  end

  def created
    Sequence.create(parse(params, $sequence_spec))
    render 'index'
  end

  def show
    @sq = Sequence.find(:all)
    
  end

  def load
    inp = Level.only('game.levelName').entries
    @levelNames = []
    inp.each do |i|
      @levelNames << i[:game]['levelName']
    end
    sn = params[:id]
    @seqOb = Sequence.all_of('levelSequence.sequenceName' => sn).first
    @level_names = @seqOb[:levelSequence]['levels']['level']    
    binding.pry   
    
  end

  def updated
    case params['change']
      when 'new'
        #TODO: ensure that there is no sequence with the same name
        seqOb = parse(params, $sequence_spec)
        Sequence.create(seqOb)
      when 'update'
        seqOb = parse(params, $sequence_spec)
        Sequence.where('levelSequence.sequenceName'=>params['sequenceName']).update_all(seqOb)
      when 'remove'
        Sequence.where('levelSequence.sequenceName'=>params['sequenceName']).delete_all()
    end
    render 'index'    
  end
  
  def xml
    sn = params[:id]
    seqOb = Sequence.all_of('levelSequence.sequenceName' => sn).first
    render :xml => seqOb
  end

end
