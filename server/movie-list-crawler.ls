# 选电影列表抓取脚本

require! {'request', 'xml2js'}

exports.get-the-movie-list = (douban-url, res)!->
  request douban-url, (error, response, body)!->
    if !error && response.statusCode == 200

      builder = new xml2js.Builder!

      object-body = JSON.parse body

      movie-list-info = []

      for one-movie in object-body.subjects
        movie = 
          rate    : one-movie.rate
          title   : one-movie.title
          url     : one-movie.url
          cover   : one-movie.cover
          id      : one-movie.id

        movie-list-info.push movie

      movie-info = {name: 'wujr', age: 20}

      movie-list = 
        movie-info : movie-info
        movie : movie-list-info

      mlxml = builder.build-object movie-list

      res.send mlxml