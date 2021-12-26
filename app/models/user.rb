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

  #foregin_key = 入り口。source = 出口

  has_many :relationships
  #架空のfollowingクラス（モデル）をこの時点で命名.捕捉:throughで中間テーブルを設定,relationshipsテーブルのfollow_idを参考にfollowingsモデルにアクセスする
  #結果、user.followingsと打つとuserが中間テーブルrelationshipsを取得、１つ１つのrelationshipのfollow_idから「フォローしているUser達」を取得
  has_many :followings, through: :relationships, source: :follow
  #has_many :relationshipsの逆方向、架空のクラスを命名しclass_nameでrelationshipモデルであると捕捉。follow_idを入り口とする。
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  #架空のクラスを命名。「出口はuser_idでuserテーブルから自分をフォローしているuserを取得する
  has_many :followers, through: :reverse_of_relationships, source: :user

def follow(other_user)
  unless self == other_user
    self.relationships.find_or_create_by(follow_id: other_user.id)
  end
end

def unfollow(other_user)
  relationship = self.relationships.find_by(follow_id: other_user.id)
  relationship.destroy if relationship
end

def following?(other_user)
  self.followings.include?(other_user)
end

end