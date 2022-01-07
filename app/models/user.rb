class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  has_many :group_users
  has_many :groups, through: :group_users
  has_many :owned_groups, class_name: "Group"

  #foregin_key = 入り口。source = 出口

  has_many :relationships
  #active_relationshipsという架空のクラス（モデル）を作成、relationshipsのfollower_idを参考にactiverelationshipsにアクセスする
  has_many :active_relationships, class_name:  "Relationship",foreign_key: "follower_id",dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",foreign_key: "followed_id",dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

def follow(user_id)
  self.active_relationships.create!(followed_id: user_id)
end

#フォローがあればアンフォローする
def unfollow(user_id)
  self.active_relationships.find_by(followed_id: user_id).destroy
end

def following?(user)
  self.following.include?(user)
end

end