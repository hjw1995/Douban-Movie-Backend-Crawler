# 选电影列表抓取脚本

require! {'request'}

exports.get-the-movie-list = (douban-url, res)!->
  request douban-url, (error, response, body)!->
    if !error && response.statusCode == 200
      object-body = JSON.parse body
      res.send JSON.stringify object-body
