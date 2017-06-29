class Movie < ActiveRecord::Base
  def self.create # FIXME
    QueryDietController.render partial: 'nested'
  end
end
