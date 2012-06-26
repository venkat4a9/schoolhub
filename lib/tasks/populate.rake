namespace :db do
  
  desc "Erase and fill database"
  task :reseed => [:environment, 'db:reset', 'db:users', 'db:categories', 'db:posts']
  
  desc "Create users"
  task :users => :environment do
    User.create name: "Jim", email: "j@j.com", password: "111111", password_confirmation: "111111"
    User.create name: "Bethany", email: "b@b.com", password: "111111", password_confirmation: "111111"
  end
  
  desc "Create categories"
  task :categories => :environment do
    cat = Category.create name: "Sports"
    cat.children.create name: "General"    
    cat.children.create name: "Football"
    cat.children.create name: "Basketball"
    cat.children.create name: "Baseball"
    cat.children.create name: "Hockey"
    cat.children.create name: "Soccer"
    cat.children.create name: "Tennis"
    cat.children.create name: "Golf"
    cat.children.create name: "Lacrosse"
    cat.children.create name: "MMA"
    cat.children.create name: "Boxing"
    cat.children.create name: "Extreme Sports"
    
    cat = Category.create name: "Fashion"
    cat.children.create name: "General"
    cat.children.create name: "Women's Apparel"
    cat.children.create name: "Shoes"
    cat.children.create name: "Handbags"
    cat.children.create name: "Jewelry/Accessories"
    cat.children.create name: "Trends"
    cat.children.create name: "Men's"
    
    cat = Category.create name: "News"
    cat.children.create name: "General"
    cat.children.create name: "Business"
    cat.children.create name: "World"
    cat.children.create name: "US"
    cat.children.create name: "Politics"
    cat.children.create name: "Technology"
    cat.children.create name: "Science"
    cat.children.create name: "Health"

    cat = Category.create name: "Music"
    cat.children.create name: "General"
    cat.children.create name: "Hip Hop/Rap"
    cat.children.create name: "Pop"
    cat.children.create name: "Rock"
    cat.children.create name: "EDM"
    cat.children.create name: "Country"
    cat.children.create name: "R&B/Soul"
    cat.children.create name: "Alternative"
    cat.children.create name: "Reggae"
    cat.children.create name: "Jazz/Blues"
    cat.children.create name: "Soundtrack"
    
    cat = Category.create name: "Literature"
    cat.children.create name: "General"
    cat.children.create name: "Fiction"
    cat.children.create name: "Non-fiction"
    cat.children.create name: "Short Stories"
    cat.children.create name: "Self-help"
    cat.children.create name: "Best-seller"
    cat.children.create name: "Biography"

    cat = Category.create name: "Movies"
    cat.children.create name: "General"
    cat.children.create name: "Comedy"
    cat.children.create name: "Drama"
    cat.children.create name: "Action"
    cat.children.create name: "Sci-fi"
    cat.children.create name: "Family"
    cat.children.create name: "Thriller/Horror"
    cat.children.create name: "Romance"
    cat.children.create name: "Upcoming"
    cat.children.create name: "Documentary"
    
    cat = Category.create name: "TV"
    cat.children.create name: "General"
    cat.children.create name: "Comedy"
    cat.children.create name: "Drama"
    cat.children.create name: "Action"
    cat.children.create name: "Reality"
    cat.children.create name: "Sci-fi"
    cat.children.create name: "Family"
    cat.children.create name: "Documentary"
    
    cat = Category.create name: "Art"
    cat.children.create name: "General"
    cat.children.create name: "Paintings"
    cat.children.create name: "Photo"
    cat.children.create name: "Street Art"
    cat.children.create name: "Modern Art"
    cat.children.create name: "Contemporary"
    cat.children.create name: "Photoshop"
    
    cat = Category.create name: "Other"
    cat.children.create name: "General"
    cat.children.create name: "Humor"
    cat.children.create name: "Food"
    cat.children.create name: "Autos"
    cat.children.create name: "Travel"
    cat.children.create name: "Fitness"
    cat.children.create name: "Nightlife"
    cat.children.create name: "Gambling/Cards"
    cat.children.create name: "Animals/Pets"
    cat.children.create name: "Gaming"
    cat.children.create name: "Celebrity Gossip"    
  end
  
  desc "Create posts"
  task :posts => :environment do
	user = User.first
    @post = user.posts.build(content: "This is the first post", category_id: Category.find_by_name("Lacrosse"), shared: false)
	@post.save
	@post = user.posts.build(content: "This is the second post", category_id: Category.find_by_name("Basketball"), shared: true)
	@post.save
  end
  
end
    
    