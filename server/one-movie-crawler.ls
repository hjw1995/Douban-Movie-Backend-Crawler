# 但个页面抓取脚本

require! {'cheerio', 'request', 'xml2js'}

exports.get-one-movie-info = (info-url, comments-url, res)->
  request comments-url, (comments-error, comments-response, comments-body)!->
    if !comments-error && comments-response.statusCode == 200

      request info-url, (info-error, info-response, info-body)!->
        if !info-error && info-response.statusCode == 200

          info = cheerio.load info-body
          comments = cheerio.load comments-body

          one-movie-info =
            baseinfo    :   get-base-movie-info info
            comments    :   get-movie-comments  comments

          builder = new xml2js.Builder!
          omixml = builder.build-object one-movie-info

          res.send omixml

get-base-movie-info = ($)->
  info = $('.subject.clearfix #info').text! .replace(/[\n]/ig, '') .replace(/\s+/g, "")

  info-item = ['导演', '编剧', '主演', '类型', '制片国家/地区', '语言', '上映日期', '片长', '又名', 'IMDb链接']
  info-var  = ['director', 'scriptwriter', 'leadingrole', 'type', 'madein', 'language', 'beon', 'length', 'anothername', 'IMDbLink']

  base-info = 
    name          :   $('#content h1 span') .text!
    imagesrc      :   $('.subject.clearfix #mainpic .nbgnbg img') .attr 'src'
    director      :   '无'
    scriptwriter  :   '无'
    leadingrole   :   '无'
    type          :   '无'
    madein        :   '无'
    language      :   '无'
    beon          :   '无'
    length        :   '无'
    anothername   :   '无'
    IMDb-link     :   '无'

  for i from 0 to info-item.length - 1
    if (info.indexOf(info-item[i]) != -1)

      left-index  = info.indexOf(info-item[i]) + info-item[i].length + 1

      if i == info-item.length - 1
        right-index = info.length
      else
        right-index = get-info-item-right-index info, info-item, left-index

      # console.log left-index, right-index, info-item[i]

      base-info[info-var[i]] = info.substring left-index, right-index 

  # console.log base-info
  base-info-array = []

  base-info-array.push base-info

  base-info-array

get-info-item-right-index = (info, info-item, left-index)->
  colon-index = info.indexOf ':', left-index

  substring-before-colon = info.substring (colon-index - 10), colon-index

  right-index = 0

  for i from 0 to info-item.length - 1
    if substring-before-colon.indexOf(info-item[i]) != -1
      right-index = info.indexOf info-item[i]

  right-index

get-movie-comments = ($)->
  all-comments = []

  $('#comments .comment-item') .each (i, elem)!->
    one-comment = 
      username  : $('.comment h3 .comment-info a', this).text!
      content   : $('.comment p', this).text!.trim!
      avatar    : $('.avatar a img', this).attr 'src'
      time      : $('.comment .comment-info span', this).text! .replace(/[\n]/ig, '') .replace(/\s+/g, "")

    all-comments .push one-comment

  all-comments
