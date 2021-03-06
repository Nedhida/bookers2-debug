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

	scope :today, -> { where(created_at: Time.zone.now.all_day)}
	scope :yesterday, -> { where(created_at: 1.day.ago.all_day)}
	scope :two_day_ago, -> { where(created_at: 2.day.ago.all_day)}
	scope :three_day_ago,-> { where(created_at: 3.day.ago.all_day)}
	scope :four_day_ago,-> { where(created_at: 4.day.ago.all_day)}
	scope :five_day_ago,-> { where(created_at: 5.day.ago.all_day)}
	scope :six_day_ago, -> { where(created_at: 6.day.ago.all_day)}
	scope :data, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
end
