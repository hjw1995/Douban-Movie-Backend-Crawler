require! {express, http, path, './movie-api', './one-movie-crawler', './movie-list-crawler'}

app = express!

app.get '/tag=:_tag&sort=:_sortBy', (req, res)!->
  if movie-api.tags.index-of(req.params._tag) isnt -1 and movie-api.sort-by.index-of(req.params._sortBy) isnt -1
    url = movie-api.movie-list-base-url + req.params._tag + movie-api.movie-list-left-url + req.params._sortBy
    result = movie-list-crawler.get-the-movie-list url
    res.send result
  else
    res.end 'Bad Request!'

app.get '/:_movieId', (req, res)!->
  url = movie-api.one-movie-base-url + req.params._movieId
  result = one-movie-crawler.get-one-movie-info url
  res.send result

exports = module.exports = app
