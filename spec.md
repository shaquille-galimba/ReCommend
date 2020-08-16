# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
	- user has_many recommends
	- brand has_many recommends
	- category has_many brands
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
	- recommend belongs_to user
	- recommend belongs_to brand
	- brand belongs_to category
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
	- user has_many brands, through recommends
	- brand has_many user, through recommends
	- category has_many recommends, through brands
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
	- user has_many brands, through recommends
	- brand has_many user, through recommends
	- category has_many recommends, through brands
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
	- Recommend model has a comment attribute (recommend.comment)
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
	- User, Brand, Category, Recommend
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
	- Brand has a most_popular scope method(Brand.most_popular) and the brand index page is ordered by most_popular (URL: /brands)
- [x] Include signup (how e.g. Devise)
	- User can signup ('/signup')
- [x] Include login (how e.g. Devise)
	- User can login ('/login')
- [x] Include logout (how e.g. Devise)
	- User can logout ('/logout')
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
	- User can login through their Google accounts using Omniauth ("/auth/:provider/callback")
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
	- Logged in users can view other users recommendations (users/:id/recommends)
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
	- Logged in users can create new recommends with an existing brand (brands/:id/recommends/new)
	- Logged in users can create new recommends with an exisitng category (categories/:id/recommends/new)
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
	- Validation errors are present in every form in the app.

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
