class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  # returns all of the other users
  # who are connected to the given user via a confirmed friendship
  # or confirmed inverse friendship
  def friends
    # user is the friendshiper so we take all of his leaders
    friends_array = friendships.map { |friendship| friendship.friend if friendship.status == true }
    # user is the leader so we take all of his friendships
    friends_array.concat(inverse_friendships.map { |friendship| friendship.user if friendship.status == true })
    friends_array.compact
  end

  # Users who have yet to confirm friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def confirm_friend(user)
    friend = inverse_friendships.find { |friendship| friendship.user == user }
    friend.status = true
    friend.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
