###
	Beer (a.k.a ActionPlan ;)
###
class Beer
	constructor: (@name, @style, @rating) ->
		@name 	= ko.observable(@name)
		@style 	= ko.observable(@style)
		@rating = ko.observable(@rating)

###
	BeerListViewModel (a.k.a. ActionPlanList ;)
###	
class BeerListViewModel
	constructor: () ->
		@customBeerReviewName   = ko.observable()
		@customBeerReviewStyle  = ko.observable()
		@customBeerReviewRating = ko.observable()

		# Holds all beers in the list	
		@beers = ko.observableArray([
			new Beer('Adam From the Wood', 'Old Ale', 4.4),
			new Beer('Bedarö Bitter', 'English Bitter', 3.9),
			new Beer('Pliny The Elder', 'American Barlewine', 5.0),
			new Beer('Pripps Blå', 'Euro Lager', 1.8)
		])

		# Calculates the highest rated beer.
		@highestRatedBeer = ko.computed () =>
			highestRatedBeer = @beers()[0]

			for beer in @beers()
				do (beer) ->
					highestRatedBeer = beer if parseFloat(beer.rating()) > parseFloat(highestRatedBeer.rating())	
			highestRatedBeer

		# Calculates the average rating of the beers. 
		@averageRating = ko.computed () =>
			averageRating = 0

			for beer in @beers()
				do (beer) ->
					averageRating += parseFloat(beer.rating())	
			
			(averageRating / @beers().length).toFixed(2)

	# Operations
	resetCustomReviewForm: () =>
		@customBeerReviewName('')
		@customBeerReviewStyle('')
		@customBeerReviewRating('')

	addBeerReview: () =>
		@beers.push(new Beer(@customBeerReviewName(), @customBeerReviewStyle(), @customBeerReviewRating())) if @customBeerReviewName()?
		@resetCustomReview

	removeBeerReview: (beer) =>
		@beers.splice(@beers().indexOf(beer), 1)



ko.applyBindings(new BeerListViewModel());


