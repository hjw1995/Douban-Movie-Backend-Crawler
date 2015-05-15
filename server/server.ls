require! {express, http, path, './movie-api', './one-movie-crawler', './movie-list-crawler'}

app = express!

app.get '/api/random', (req, res)!-> 
  from = req.param 'from'
  # console.log movie-api
  set-timeout !->
    res.set 'Content-Type', 'text/plain'
    res.send '' + random = Math.floor Math.random! * 10
    console.log "Request from #{from}, answer random number: #{random}"
  , 1000ms + Math.random! * 2000ms

# server.listen host-config.end-server.port

app.get '/tag=:_tag&sort=:_sortBy', (req, res)!->
  if movie-api.tags.index-of(req.params._tag) isnt -1 and movie-api.sort-by.index-of(req.params._sortBy) isnt -1
    console.log req.params._tag
    console.log req.params._sortBy
    console.log one-movie-crawler.name
    console.log movie-list-crawler.name
    res.send 'wujiarong'
  else
    res.end!

app.get '/:_movieId', (req, res)!->
  console.log req.params._movieId
  res.send 'hahahah'

exports = module.exports = app
