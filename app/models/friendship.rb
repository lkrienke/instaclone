class Friendship < ApplicationRecord
	# user_id will be the receiver, and friend_id will correspond with the requester
	belongs_to :user
	belongs_to :friend, class_name: "User"
end
