# 存储需要抓取的url和相应的sort
# url例子：http://movie.douban.com/explore#!type=movie&tag={tag名}&sort={sort名}&page_limit=20&page_start=0
# 相同部分：'http://movie.douban.com/explore#!type=movie&tag=' 和 '&sort='
# 单部电影的url：http://movie.douban.com/subject/24405378/
# http://movie.douban.com/j/search_subjects?type=movie&tag=%E7%83%AD%E9%97%A8&sort=time&page_limit=20&page_start=0
# http://movie.douban.com/subject/25745752/comments?start=0&limit=20&sort=new_score

url = {}

url.one-movie-base-url = 'http://movie.douban.com/subject/'

url.comments-base-url = 'http://movie.douban.com/subject/'

url.comments-left-url = '/comments?start=0&limit=20&sort=new_score'

url.movie-list-base-url = 'http://movie.douban.com/j/search_subjects?type=movie&tag='

url.movie-list-mida-url = '&sort='

url.movie-list-midb-url = '&page_limit='

url.movie-list-tail-url = '&page_start=0'

url.tags = ['热门', '最新', '经典', '可播放', '豆瓣高分', '冷门佳片', '华语', '欧美', '韩国', '日本', '动作', '喜剧', '爱情', '科幻', '悬疑', '恐怖', '动画']

url.sort-by = ['recommend', 'time', 'rank']

module.exports = exports = url
