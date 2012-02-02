class Experiment
  include Mongoid::Document
  field :experimentName, :type => String
  field :sequence, :type => Array
end
