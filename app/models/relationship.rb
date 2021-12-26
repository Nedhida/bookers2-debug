class Relationship < ApplicationRecord

  belongs_to :user
  #followモデルは存在しないので、userモデルにbelongs_toさせる
  belongs_to :follow, class_name: "User"

  validates :user_id, presence: true
  validates :follow_id, presence: true

end
