class ExperimentsController < ApplicationController
  def create
    inp = Sequence.only('levelSequence.sequenceName').entries
    @sequenceNames = []
    inp.each do |i|
      @sequenceNames << i[:levelSequence]['sequenceName']
    end
  end

  def created
    params['next'] = 0
    Experiment.create(params)
    render 'index'
  end

  def index
  end

  def load
    inp = Sequence.only('levelSequence.sequenceName').entries
    @sequenceNames = []
    inp.each do |i|
      @sequenceNames << i[:levelSequence]['sequenceName']
    end
    en = params[:id]
    @expOb = Experiment.all_of('experimentName' => en).first
  end

  def show
    inp = Experiment.only('experimentName').entries
    @experiment_names = []
    inp.each do |i|
      @experiment_names << i['experimentName']
    end
  end

  def updated
    params['next'] = 0
    case params['change']
      when 'new'
        Experiment.create(params)
      when 'update'
        Experiment.where('experimentName'=>params['experimentName']).update_all(params)
      when 'remove'
        Experiment.where('experimentName'=>params['experimentName']).delete_all()
    end
    render 'index'        
  end

  def xml
  end

end
