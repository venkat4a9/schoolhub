class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :category
  
  has_many   :post_actions, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :favorites, dependent: :destroy
  has_many   :comments, dependent: :destroy

  attr_accessible :content, :category_id, :shared, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  validates :user_id, presence: true
  validates :category_id, presence: true
  
  has_attached_file :image,
    :styles => { :normal => "250", :large => "450" }, 
	  :storage => :s3,
	  :s3_credentials => "#{Rails.root}/config/s3.yml",
	  :path => ":attachment/:id/:style.:extension",
	  :bucket => "ultrakast_images"
  
  scope :shared, lambda { |user| where("shared = ? OR user_id = ?", true, user) unless user.nil? }
  scope :by_users, lambda { |users| where("user_id IN (?)", users) unless users.nil? }
  scope :by_categories, lambda { |categories| where("category_id IN (?)", categories) unless categories.nil? }
  scope :popular, order("posts.post_actions_count desc")
  scope :recent, order("posts.created_at DESC")
  scope :favorites, lambda { |user| where("id IN (?)", User.find(user).favorites.collect(&:post_id)) unless user.nil? }
  scope :since, lambda { |date| where("updated_at > ?", date) unless date.nil? }
 
  # ENTIRE UNREAD FUNCTIONALITY NEEDS TO BE REWORKED FROM SCRATCH
  #acts_as_readable
  #Get count of unread posts, sorted by category, posted by a user's friends
  #Returns a string showing number of new posts to append to the category links
  
  #ideas to make this better?
  #have unread check done at parent level, pass back array of counts, somehow add them to the child links? (dictionary with cat ID as key?)
  #store these counts somewhere with last post time and don't refresh unless new post is made?
  
  
  def self.unread_count(user, category)
	
	#No friends? No count. Exit
	if user.friends.count == 0
	  return
	else
	  friends = user.friends
	end

	if category.ancestry.nil?
	  cat_ids = user.categories.ids & category.children.ids
	else
	  cat_ids = [category.id]
	end
	
	#No posts in category or new posts since read_time? Exit
	#if by_categories(cat_ids).last.nil?
	#  return
	#end
	
	#if read_time.last_read_time > by_categories(cat_ids).last.updated_at
	#  return
	#end

	#unread = where("updated_at > ? AND category_id = ? AND user_id IN (?)", category.id, read_time.last_read_time, friends).count
	unread = 0
	cat_ids.each do |c|
	  read_time = ReadStatus.where("user_id = ? AND category_id = ?", user.id, c).first
	  if read_time.nil?
	    read_time = ReadStatus.create!(:user_id => user.id, :category_id => c, :last_read_time => Time.now)
	  end
		
	  unread = unread + by_users(friends).since(read_time.last_read_time).by_categories(c).count
	end
	
	unless unread == 0
        "(" + unread.to_s + " new)"
	end
  end
 
end


