Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "articles#index"

  # get "/articles", to: "articles#index"
  # 上面的路由宣告 GET /articles 要求會對應到 ArticlesController 的 index 動作。
  # get "/articles/:id", to: "articles#show"
  # 新的路由是另一個 get 路由，但它的路徑中有些額外的東西：:id。
  # 這指定一個路由參數。路由參數 擷取請求路徑的區段，並將該值放入 params Hash，控制器動作可以存取該 Hash。
  # 例如，在處理類似 GET http://localhost:3000/articles/1 的請求時，1 會被擷取為 :id 的值，然後可以在 ArticlesController 的 show 動作中存取為 params[:id]。

  # 到目前為止，我們已經介紹了 CRUD 中的「R」(讀取)。
  # 我們最終會介紹「C」(建立)、「U」(更新) 和「D」(刪除)。正如你可能猜到的，我們將透過新增 路由、控制器動作 和 檢視 來執行這些操作。
  # 每當我們有路由、控制器動作 和 檢視 的組合，共同 對 實體 執行 CRUD 操作時，我們稱該實體為 資源。例如，在我們的應用程式中，我們會說 一篇文章 是一個資源。

  # Rails 提供了一個名為 resources 的路由方法，可對資源集合（例如文章）的所有 慣例路由 進行對應。
  resources :articles
  # articles     GET    /articles(.:format)                     articles#index 顯示 所有文章的清單
  #              POST   /articles(.:format)                     articles#create 建立新文章
  # new_article  GET    /articles/new(.:format)                 articles#new 傳回用於 建立 新文章 的 HTML 表單
  # edit_article GET    /articles/:id/edit(.:format)            articles#edit 傳回用於編輯文章的 HTML 表單
  #      article GET    /articles/:id(.:format)                 articles#show 顯示 特定 文章
  #              PATCH  /articles/:id(.:format)                 articles#update 更新 特定 文章
  #              PUT    /articles/:id(.:format)                 articles#update 更新 特定 文章
  #              DELETE /articles/:id(.:format)                 articles#destroy 刪除 特定 文章
  # resources 方法也會設定 URL 和 路徑輔助方法，我們可以使用 這些方法 來避免 我們的程式碼 依賴於 特定的 路由設定。
  # 上面「前置詞」欄中的值加上 _url 或 _path 後綴會形成這些輔助方法的名稱。
  # 例如，當給定一篇文章時，article_path 輔助方法會傳回 "/articles/#{article.id}"。我們可以使用它來整理 app/views/articles/index.html.erb 中的連結



end
