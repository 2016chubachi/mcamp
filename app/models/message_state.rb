class MessageState < ActiveRecord::Base
    has_many :requests
    has_many :borrowreplys
end
