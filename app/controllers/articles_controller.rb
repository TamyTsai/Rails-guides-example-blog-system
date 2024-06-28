# $ rails g controller articles index --skip-routes

class ArticlesController < ApplicationController
  # Rails 應用程式不會使用 require 來載入應用程式程式碼。
  # 您可能已注意到 ArticlesController 繼承自 ApplicationController，但 app/controllers/articles_controller.rb 沒有任何require

  # 幾乎所有網路應用程式都涉及 CRUD（建立、讀取、更新和刪除） 作業。您甚至可能會發現您的應用程式所做的工作大部分都是 CRUD。
  # Rails 承認這一點，並提供了許多功能來協助簡化執行 CRUD 的程式碼。

  def index
    @articles = Article.all
  end

  def show
    # show 動作呼叫 Article.find（先前提到過），其中包含路由參數擷取的 ID。傳回的文章儲存在 @article 執行實體變數中，因此view可以存取它。
    # 預設情況下，show 動作會呈現 app/views/articles/show.html.erb。
    @article = Article.find(params[:id])
    # 新的路由是另一個 get 路由，但它的路徑中有些額外的東西：:id。這指定一個路由參數。
    # 路由參數擷取請求路徑的區段，並將該值放入 params Hash，控制器動作可以存取該 Hash。
    # 例如，在處理類似 GET http://localhost:3000/articles/1 的請求時，1 會被擷取為 :id 的值，然後可以在 ArticlesController 的 show 動作中存取為 params[:id]。
  end

end
