require! {express, http, path, './movie-api', './one-movie-crawler', './movie-list-crawler'}

app = express!

app.get '/tag=:_tag&sort=:_sortBy', (req, res)!->
  if movie-api.tags.index-of(req.params._tag) isnt -1 and movie-api.sort-by.index-of(req.params._sortBy) isnt -1
    url = movie-api.movie-list-base-url + req.params._tag + movie-api.movie-list-midd-url + req.params._sortBy + movie-api.movie-list-tail-url
    url = encodeURI url
    movie-list-crawler.get-the-movie-list url, res
  else
    res.end 'Bad Request!'

app.get '/:_movieId', (req, res)!->
  if /^[0-9]*$/.test req.params._movieId

    info-url = movie-api.one-movie-base-url + req.params._movieId
    comments-url = movie-api.comments-base-url + req.params._movieId + movie-api.comments-left-url
    
    one-movie-crawler.get-one-movie-info info-url, comments-url, res
  else
    res.end 'Bad Request!'

exports = module.exports = app
