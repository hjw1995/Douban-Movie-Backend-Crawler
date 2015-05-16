# 选电影列表抓取脚本

require! {'http', 'cheerio', 'url', 'request'}

exports.get-the-movie-list = (douban-url, res)!->
  request douban-url, (error, response, body)!->
    if !error && response.statusCode == 200
      console.log(body)
      res.send body
      