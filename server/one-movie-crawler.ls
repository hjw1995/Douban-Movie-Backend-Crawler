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
            base-info   :   get-base-movie-info info
            comments    :   get-movie-comments  comments

          builder = new xml2js.Builder!
          omixml = builder.build-object one-movie-info

          res.send omixml

get-base-movie-info = ($)->
  info = $('.subject.clearfix #info').text! .replace(/[\n]/ig, '') .replace(/\s+/g, "")

  # console.log info

  movie-type          = ''
  movie-be-on         = ''
  movie-length        = ''
  movie-another-name  = ''

  if info.indexOf('官方网站') != -1
    movie-type = info.substring info.indexOf('类型') + 3, info.indexOf('官方网站')
  else
    movie-type = info.substring info.indexOf('类型') + 3, info.indexOf('制片国家')

  if info.indexOf('片长') != -1
    movie-be-on = info.substring info.indexOf('上映日期') + 5, info.indexOf('片长')
  else
    movie-be-on = info.substring info.indexOf('上映日期') + 5, info.indexOf('又名')

  if info.indexOf('又名') !=  -1
    if info.indexOf('片长') != -1
      movie-length      = info.substring info.indexOf('片长') + 3, info.indexOf('又名')
    else
      movie-length      = '无'

    movie-another-name  = info.substring info.indexOf('又名') + 3, info.indexOf('IMDb链接')
  else
    movie-length = info.substring info.indexOf('片长') + 3, info.indexOf('IMDb链接')
    movie-another-name = '无'

  base-info = 
    movie-name          :   $('#content h1 span') .text!
    movie-image-src     :   $('.subject.clearfix #mainpic .nbgnbg img') .attr 'src'
    movie-director      :   info.substring info.indexOf('导演') + 3     ,   info.indexOf('编剧')
    movie-scriptwriter  :   info.substring info.indexOf('编剧') + 3     ,   info.indexOf('主演')
    movie-leading-role  :   info.substring info.indexOf('主演') + 3     ,   info.indexOf('类型')
    movie-type          :   movie-type
    movie-made-in       :   info.substring info.indexOf('制片国家') + 8  ,   info.indexOf('语言')
    movie-language      :   info.substring info.indexOf('语言') + 3      ,  info.indexOf('上映日期')
    movie-be-on         :   movie-be-on
    movie-length        :   movie-length
    movie-another-name  :   movie-another-name
    movie-IMDb-link     :   info.substring(info.indexOf('IMDb链接') + 7)

get-movie-comments = ($)->
  # console.log $.html!
  # console.log $('#comments .comment-item').text!
  all-comments = []

  $('#comments .comment-item') .each (i, elem)!->
    one-comment = 
      username  : $('.comment h3 .comment-info a', this).text!
      content   : $('.comment p', this).text!.trim!
      avatar    : $('.avatar a img', this).attr 'src'
      time      : $('.comment .comment-info span', this).text! .replace(/[\n]/ig, '') .replace(/\s+/g, "")

    all-comments .push one-comment

  all-comments
