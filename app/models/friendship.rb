class Friendship < ApplicationRecord
	# user_id will be the receiver, and friend_id will correspond with the requester
	belongs_to :user
	belongs_to :friend, class_name: "User"

	def accepted_friendships(friendships)
		friendships.where(accepted: true)
	end

	def pending_friendships(friendships)
		friendships.where(accepted: false)
	end
end
