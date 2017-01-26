class User <ActiveRecord::Base
  has_many :recipes

  has_secure_password #bcrypt method- to encrypt pass. through salting and hashing as soon as it gets saved to the database. (so, not "in the clear" which would be unsafe)

  validates :username, :email, presence: true

  validates :email, :username, uniqueness: true

  def slug #when I use this method for slugging users' names in more routes that offer users more functionality, I won't use "title" I will use username.whatever...so this is kind of an armiture for something I'm about to build next. 
    title.strip.downcase.gsub(/(&|&amp;)/, ' and ').gsub(/[\s\.\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-_]{2,}/, '-').gsub(/^[-_]/, '').gsub(/[-_]$/, '')
  end
#this too, actually
  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug}
  end

end