#concerns是一種讓 大型 控制器 或 模型 更容易理解和管理 的 方式。
# 當多個模型（或控制器）共用相同的concerns時，這也有 可重複使用的優點。concerns是使用模組實作的，這些模組包含代表模型或控制器負責的功能中定義良好的區塊的方法。在其他語言中，模組通常稱為混入。

# 您可以在控制器或模型中使用concerns，就像使用任何模組一樣。當您第一次使用 rails new blog 建立應用程式時，會在 app/ 中建立兩個資料夾以及其他資料夾
# app/controllers/concerns
# app/models/concerns
# 讓程式碼更 DRY 且更易於維護。

# 但是，如果您現在再次查看我們的 模型，您會看到 邏輯是重複的。如果未來我們增加部落格的功能 - 例如，包含私人訊息 - 我們可能會發現自己 再次重複邏輯。這正是concerns派上用場的地方。
# concerns僅負責 模型責任 的 焦點子集；我們concerns中的方法 都與 模型的 可見性 有關。
# 讓我們將我們的新concerns（模組）稱為 Visible。我們可以在 app/models/concerns 內建立一個稱為 visible.rb 的新檔案，並 儲存 模型中 重複的 所有 狀態方法。

module Visible
    # 我們可以將 狀態驗證 新增至 concern，但這會稍微複雜一些，因為驗證是在 類別層級 呼叫的方法。
    # ActiveSupport::Concern (API 指南) 提供了更簡單的方法 來包含它們
    extend ActiveSupport::Concern # 擴充 擴充該模組中的方法 變 類別方法

    VALID_STATUSES = ['public', 'private', 'archived']
    # 可見狀態 有三種 公開、私人、封存

    included do
        validates :status, inclusion: { in: VALID_STATUSES }
        # 驗證 資料表中 狀態欄位值 是否為 可見狀態陣列 中的其中一種
    end

    # 類別方法 也可以新增至 concerns。如果我們要在 主頁面 顯示 公開文章 或 留言 的 數量，我們可以在 Visible 中新增 類別方法，如下所示
    # 然後在檢視中，您可以像呼叫任何類別方法一樣呼叫它
    class_methods do
        def public_count
            where(status: 'public').count
        end
    end

    def archived?
        status == "archived"
    end
end