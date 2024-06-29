# $ rails g model Comment commenter body:text article:references
# 這個指令將會產生四個檔案
# invoke  active_record
# create    db/migrate/20240629042854_create_comments.rb  --在你的資料庫中建立留言表格的遷移（你的名稱將包含不同的時間戳記）
# create    app/models/comment.rb  --留言模型
# invoke    test_unit
# create      test/models/comment_test.rb  --留言模型的測試架構
# create      test/fixtures/comments.yml --用於測試的範例留言

class Comment < ApplicationRecord
  include Visible

  belongs_to :article # 讓每個留言 都屬於 一篇文章
  # 這與您稍早看到的 Article模型 非常相似。不同之處在於belongs_to :article行，它設定了 Active Record 關聯。
  # Active Record 關聯讓您可以輕鬆宣告兩個模型之間的關係。在留言和文章的情況下，您可以用這種方式寫出關係：
  # 每個留言 都屬於 一篇文章。
  # 一篇文章 可以有 許多留言。
  # 事實上，這非常接近 Rails 用來宣告此關聯的語法。
  
  # 在 article 模型中，在執行遷移以使用 bin/rails db:migrate 指令新增 status 欄位後，您會新增：
  # VALID_STATUSES = ['public', 'private', 'archived']

  # validates :status, inclusion: { in: VALID_STATUSES }

  # def archived?
  #     status == "archived"
  # end

end

