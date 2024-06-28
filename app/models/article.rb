# rails generate model Article title:string body:text
# 模型名稱是單數，因為一個實例化模型表示一個單一資料記錄。為了幫助您記住此慣例，請想想您會如何呼叫模型的建構函式：我們想要寫 Article.new(...)，不是 Articles.new(...)。

class Article < ApplicationRecord
end
