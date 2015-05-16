# 但个页面抓取脚本

require! {'cheerio', 'request'}

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

          res.send JSON.stringify one-movie-info

get-base-movie-info = ($)->
  info = $('.subject.clearfix #info').text! .replace(/[\n]/ig, '') .replace(/\s+/g, "")

  base-info = 
    movie-name          :   $('#content h1 span') .text!
    movie-image-src     :   $('.subject.clearfix #mainpic .nbgnbg img') .attr 'src'
    movie-director      :   info.substring(info.indexOf('导演') + 3, info.indexOf('编剧'))
    movie-scriptwriter  :   info.substring(info.indexOf('编剧') + 3, info.indexOf('主演'))
    movie-leading-role  :   info.substring(info.indexOf('主演') + 3, info.indexOf('类型'))
    movie-type          :   info.substring(info.indexOf('类型') + 3, info.indexOf('制片国家'))
    movie-made-in       :   info.substring(info.indexOf('制片国家') + 8, info.indexOf('语言'))
    movie-language      :   info.substring(info.indexOf('语言') + 3, info.indexOf('上映日期'))
    movie-be-on         :   info.substring(info.indexOf('上映日期') + 5, info.indexOf('片长'))
    movie-length        :   info.substring(info.indexOf('片长') + 3, info.indexOf('又名'))
    movie-another-name  :   info.substring(info.indexOf('又名') + 3, info.indexOf('IMDb链接'))
    movie-IMDb-link     :   info.substring(info.indexOf('IMDb链接') + 7)

get-movie-comments = ($)->
  console.log $('.mod-bd').html!
  '吴家荣'
