# rails generate model Article title:string body:text
# 遷移用於 變更 應用程式資料庫 的 結構。在 Rails 應用程式中，遷移會以 Ruby 編寫，以便它們與 資料庫 無關。

class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
    # 呼叫 create_table 指定 articles 表格應如何建構。預設情況下，create_table 方法會新增一個 id 欄位作為自動遞增的主鍵。因此，表格中的第一筆記錄的 id 會是 1，下一筆記錄的 id 會是 2，以此類推。
      t.string :title
      t.text :body

      t.timestamps
      # t.timestamps。此方法定義兩個額外的欄位，分別命名為 created_at 和 updated_at。正如我們將看到的，Rails 會為我們管理這些欄位，在我們 建立 或 更新 模型物件 時設定其值。
    end
  end
end

# rails db:migrate
# -- create_table(:articles)
# -> 0.0055s

# rails c
  # 3.0.0 :001 > article = Article.new(title: "Hello Rails", body: "I am on Rails!")  --初始化一個新的 Article 物件
  # => #<Article:0x000000011c9f30b8 id: nil, title: "Hello Rails", body: "I am on Rails!", created_at: nil, updated_at: nil> 
  # 3.0.0 :002 > article.save  --請注意，我們只初始化此物件。此物件並未儲存至資料庫中。它目前僅在主控台中可用。若要將物件儲存至資料庫中，我們必須呼叫 save
  #  TRANSACTION (0.4ms)  BEGIN
  #  Article Create (5.0ms)  INSERT INTO "articles" ("title", "body", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["title", "Hello Rails"], ["body", "I am on Rails!"], ["created_at", "2024-06-28 10:53:25.471743"], ["updated_at", "2024-06-28 10:53:25.471743"]]
  # 上述輸出顯示 INSERT INTO "articles" ... 資料庫查詢。這表示已將文章 插入 我們的資料表中。
  #  TRANSACTION (0.6ms)  COMMIT
  # => true 
  # 3.0.0 :004 > article --如果我們再查看 article 物件，我們會看到發生了一些有趣的事情
  # => 
  # #<Article:0x000000011c9f30b8
  # id: 1,
  # title: "Hello Rails",
  # body: "I am on Rails!",
  # created_at: Fri, 28 Jun 2024 10:53:25.471743000 UTC +00:00,
  # updated_at: Fri, 28 Jun 2024 10:53:25.471743000 UTC +00:00>   --物件的 id、created_at 和 updated_at 屬性現在已設定。Rails 在我們 儲存 物件 時 為我們執行此動作。
  # 3.0.0 :005 > Article.find(1) --當我們想要從資料庫中擷取此文章時，我們可以在模型上呼叫 find 並傳遞 id 作為引數
  #  Article Load (0.7ms)  SELECT "articles".* FROM "articles" WHERE "articles"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  # => 
  # #<Article:0x0000000109749a28
  # id: 1,
  # title: "Hello Rails",
  # body: "I am on Rails!",
  # created_at: Fri, 28 Jun 2024 10:53:25.471743000 UTC +00:00,
  # updated_at: Fri, 28 Jun 2024 10:53:25.471743000 UTC +00:00> 
  # 3.0.0 :006 > Article.all --當我們想要從資料庫中擷取所有文章時，我們可以在模型上呼叫 all，此方法會傳回 ActiveRecord::Relation 物件，您可以將其視為超強大的 陣列。
  #  Article Load (0.4ms)  SELECT "articles".* FROM "articles" /* loading for pp */ LIMIT $1  [["LIMIT", 11]]
  # => 
  # [#<Article:0x000000011cbb4dc0
  #  id: 1,
  #  title: "Hello Rails",
  #  body: "I am on Rails!",
  #  created_at: Fri, 28 Jun 2024 10:53:25.471743000 UTC +00:00,
  #  updated_at: Fri, 28 Jun 2024 10:53:25.471743000 UTC +00:00>] 