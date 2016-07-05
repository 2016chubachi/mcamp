class LoanItem < ActiveRecord::Base
    belongs_to :member
    belongs_to :category
    belongs_to :loan_state
    #has_many :requests,->{scope :loginuser},:dependent => :destroy
    #has_many :requests, ->(member){ where member_id: member.point },:dependent => :destroy
    #has_many :requests, ->(userid){ where member_id: userid },:dependent => :destroy
    has_many :requests,:dependent => :destroy
    #has_many :loan_item_images,:dependent => :destroy
    has_one :loan_item_image,:dependent => :destroy
    accepts_nested_attributes_for :loan_item_image, allow_destroy: true
    accepts_nested_attributes_for :requests

    validates :item_name, presence: true
    validates :fare, numericality: { only_integer: true, greater_than_or_equal_to: 0}

end
