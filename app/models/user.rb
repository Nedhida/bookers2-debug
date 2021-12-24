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
  #foreign_key: "follower_id"外部キー
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  #source: 参照先を指定するキー
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end

#ユーザーをフォローする
def follow(other_user)
  active_relationships.create(followed_id: other_user.id)
end

#ユーザーをアンフォローする
def unfollow(other_user)
  active_relationships.find_by(followed_id: other_user.id).destroy
end

#現在のユーザーがフォローしていたらtrueを返す
def following?(other_user)
  following.include?(other_user)
end