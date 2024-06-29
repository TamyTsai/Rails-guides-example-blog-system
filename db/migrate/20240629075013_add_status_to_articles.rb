# $ rails g migration AddStatusToArticles status

class AddStatusToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :status, :string
  end
end

# rails db:migrate
# -- add_column(:articles, :status, :string)
#    -> 0.0010s

# 若要 新增 現有文章和留言的狀態，您可以透過新增 default: "public" 選項並再次啟動遷移，將 預設值 新增到 產生的遷移檔案 中。
# 您也可以在 rails 主控台中呼叫 Article.update_all(status: "public") 和 Comment.update_all(status: "public")。