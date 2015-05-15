# 存储需要抓取的url和相应的sort
# url例子：http://movie.douban.com/explore#!type=movie&tag={tag名}&sort={sort名}&page_limit=20&page_start=0
# 相同部分：'http://movie.douban.com/explore#!type=movie&tag=' 和 '&sort='

url = {}

url.base-url = 'http://movie.douban.com/explore#!type=movie&tag='

url.left-url = '&sort='

url.tags = ['热门', '最新', '经典', '可播放', '豆瓣高分', '冷门佳片', '华语', '欧美', '韩国', '日本', '动作', '喜剧', '爱情', '科幻', '悬疑', '恐怖', '动画']

url.sort-by = ['recommend', 'time', 'rank']

module.exports = exports = url
