class Relationship < ApplicationRecord

  belongs_to :user
  #followモデルは存在しないので、userモデルにbelongs_toさせる
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

end
