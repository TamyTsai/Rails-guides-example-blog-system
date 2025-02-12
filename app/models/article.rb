# rails generate model Article title:string body:text
# 模型名稱是單數，因為一個實例化模型表示一個單一資料記錄。為了幫助您記住此慣例，請想想您會如何呼叫模型的建構函式：我們想要寫 Article.new(...)，不是 Articles.new(...)。

class Article < ApplicationRecord
    include Visible # 引入concerns模組，就可以用 該模組內 的方法

    has_many :comments, dependent: :destroy
    # 一篇文章 可以有 許多留言。
    # 這個宣告啟用了相當多的自動行為。例如，如果您有一個 包含文章 的 實體變數@article，您可以使用@article.comments將所有 屬於 該文章 的 留言 作為 陣列 擷取。
    # 刪除 關聯物件：如果您刪除一篇文章，其相關的留言也需要被刪除，否則它們只會佔用資料庫空間。Rails 允許您使用關聯的 dependent 選項來達成此目的。

    # 正如我們所見，建立 資源 是一個多步驟的程序。處理 無效的 使用者輸入 是該程序的另一個步驟。
    # Rails 提供了一項稱為 驗證 的功能，以協助我們處理無效的使用者輸入。
    # 驗證是在 儲存 模型物件 之前 檢查的規則。如果任何檢查失敗，儲存 將會中止，而且 適當的錯誤訊息 將會新增至 模型物件 的 errors 屬性。
    validates :title, presence: true # 宣告 title 值必須存在。由於 title 是字串，這表示 title 值必須包含至少一個 非空白字元。
    validates :body, presence: true, length: { minimum: 10 } # 宣告 body 值也必須存在。此外，它宣告 body 值必須至少有 10 個字元長。
    # 您可能會想知道 title 和 body 屬性 是在哪裡定義的。Active Record（把從 資料表 的 一筆資料 包裝成 一個物件，並可在 物件上 增加 額外的 邏輯操作，讓 資料 的 存取 更便利） 會自動為 每個資料表 欄位 定義 模型屬性，
    # 因此您不必在 模型檔案中 宣告這些 屬性。

    # 在 article 模型中，在執行遷移以使用 bin/rails db:migrate 指令新增 status 欄位後，您會新增：
    # VALID_STATUSES = ['public', 'private', 'archived']

    # validates :status, inclusion: { in: VALID_STATUSES }

    # def archived?
    #     status == "archived"
    # end
    # 但是，如果您現在再次查看我們的模型，您會看到邏輯是重複的。如果未來我們增加部落格的功能 - 例如，包含私人訊息 - 我們可能會發現自己再次重複邏輯。這正是concern派上用場的地方。

end
