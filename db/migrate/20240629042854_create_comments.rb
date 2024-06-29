  # # $ rails g model Comment commenter body:text article:references
  # shell層指令中使用的（:references）關鍵字是 模型 的 特殊資料類型。它會在您的 資料庫表格上 建立一個 新欄位，其附加上一個_id，並附有可以 容納 整數值 的 已提供模型名稱。若要更深入了解，請在執行遷移後分析db/schema.rb檔案。


class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :article, null: false, foreign_key: true
      # t.references行 會 建立 一個稱為article_id的 整數欄位，以及一個 索引，並建立一個 指向articles表格 的id欄位 的 外部key約束。

      t.timestamps
    end
  end
end

# rails db:migrate
# == 20240629042854 CreateComments: migrating ===================================
# -- create_table(:comments)
# -> 0.0123s
# == 20240629042854 CreateComments: migrated (0.0123s) ==========================
# Rails 足夠聰明，只會 執行 尚未針對 目前資料庫 執行的遷移