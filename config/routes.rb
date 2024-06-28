Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "articles#index"

  get "/articles", to: "articles#index"
  # 上面的路由宣告 GET /articles 要求會對應到 ArticlesController 的 index 動作。
  get "/articles/:id", to: "articles#show"
  # 新的路由是另一個 get 路由，但它的路徑中有些額外的東西：:id。
  # 這指定一個路由參數。路由參數 擷取請求路徑的區段，並將該值放入 params Hash，控制器動作可以存取該 Hash。
  # 例如，在處理類似 GET http://localhost:3000/articles/1 的請求時，1 會被擷取為 :id 的值，然後可以在 ArticlesController 的 show 動作中存取為 params[:id]。

  # 到目前為止，我們已經介紹了 CRUD 中的「R」(讀取)。
  # 我們最終會介紹「C」(建立)、「U」(更新) 和「D」(刪除)。正如你可能猜到的，我們將透過新增 路由、控制器動作 和 檢視 來執行這些操作。
  # 每當我們有路由、控制器動作 和 檢視 的組合，共同 對 實體 執行 CRUD 操作時，我們稱該實體為 資源。例如，在我們的應用程式中，我們會說 一篇文章 是一個資源。


end
