class Movie < ActiveRecord::Base
  def self.create # FIXME
    RenderDietController.render partial: 'nested'
  end
end
