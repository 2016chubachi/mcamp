class AdUser < ActiveRecord::Base
    belongs_to :authority
    belongs_to :business
    has_many :ads

end
