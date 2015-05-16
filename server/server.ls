require! {express, http, path, './movie-api', './one-movie-crawler', './movie-list-crawler'}

app = express!

movie-list-count = 0
one-movie-count = 0

app.get '/tag=:_tag&sort=:_sortBy', (req, res)!->
  if movie-api.tags.index-of(req.params._tag) isnt -1 and movie-api.sort-by.index-of(req.params._sortBy) isnt -1

    movie-list-count++
    console.log 'Get the movie list for the ' + movie-list-count + ' th time'

    url = movie-api.movie-list-base-url + req.params._tag + movie-api.movie-list-midd-url + req.params._sortBy + movie-api.movie-list-tail-url
    url = encodeURI url
    movie-list-crawler.get-the-movie-list url, res
  else
    res.end 'Bad Request!'

app.get '/:_movieId', (req, res)!->
  if /^[0-9]*$/.test req.params._movieId

    one-movie-count++
    console.log 'Get the one movie info for the ' + one-movie-count + 'th time'

    info-url = movie-api.one-movie-base-url + req.params._movieId
    comments-url = movie-api.comments-base-url + req.params._movieId + movie-api.comments-left-url

    one-movie-crawler.get-one-movie-info info-url, comments-url, res
  else
    res.end 'Bad Request!'

exports = module.exports = app
