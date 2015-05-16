# 选电影列表抓取脚本

require! {'request', 'xml2js'}

exports.get-the-movie-list = (douban-url, res)!->
  request douban-url, (error, response, body)!->
    if !error && response.statusCode == 200

      builder = new xml2js.Builder!

      object-body = JSON.parse body

      movie-list = [one-movie for one-movie in object-body.subjects]
      mlxml = builder.buildObject movie-list

      res.send mlxml