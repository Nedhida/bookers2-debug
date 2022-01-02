class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorite_users, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy

	def favorited_by?(user)
    	favorites.where(user_id: user.id).exists?
	end


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	scope :created_today, -> { where(created_at: Time.zone.now.all.day)}
	scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day)}
end
