Models

User
 - has_many :recommends
 - has_many :brands, through: :recommends
 - has_many :categories, through: :brands
 - first_name
 - last_name
 - username
 - password

Recommend
 - belongs_to :user
 - belongs_to :brand
 - comment

Brand
 - belongs_to :categories
 - has_many :recommends
 - has_many :users, through: :recommends
 - name

Category
 - has_many :brands
 - name
