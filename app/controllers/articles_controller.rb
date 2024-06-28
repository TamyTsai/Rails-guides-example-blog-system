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
    # 例如，在處理類似 GET http://localhost:3000/articles/1 的請求時，1 會被擷取為 :id 的值（路由參數），然後可以在 ArticlesController 的 show 動作中存取為 params[:id]。
  end

  # 現在我們要繼續進行 CRUD 的「C」（建立）。
  # 通常，在網路應用程式中，建立新資源是一個多步驟的流程。
  # 首先，使用者會要求一個表單來填寫。
  # 然後，使用者會提交表單。如果沒有錯誤，資源就會建立，並會顯示某種確認訊息。否則，表單會重新顯示錯誤訊息，並重複這個流程。
  # 在 Rails 應用程式中，這些步驟通常會由控制器的 new 和 create 動作來處理。
  def new
    # new 動作會實例化一個新文章，但不會儲存它。這個文章會在建立表單時用於檢視。
    @article = Article.new
  end

  def create
    # create 動作會以標題和內文的數值建立一則新文章，並嘗試儲存它。

    # @article = Article.new(title: "...", body: "...")
    # 已提交的 表單資料 會放入 params Hash，與 擷取的路由參數 並列。
    # 因此，create 動作可透過 params[:article][:title] 存取已提交的標題，並透過 params[:article][:body] 存取已提交的內文。
    # 我們可以將這些值個別傳遞給 Article.new，但這會很冗長，而且可能會容易出錯。而且隨著我們 新增更多欄位，情況會變得更糟。
    # 相反地，我們會傳遞一個 包含值 的 單一 Hash。不過，我們仍必須指定該 Hash 中 允許 哪些值。否則，惡意使用者可能會提交 額外 的表單欄位 並 覆寫 私人資料。
    # 事實上，如果我們將未經過濾（資料清洗）的 params[:article] Hash 直接傳遞給 Article.new，Rails 會引發 ForbiddenAttributesError 來提醒我們這個問題。
    # 因此，我們將使用 Rails 的一項稱為 強參數 的功能來過濾 params。可以將它視為 params 的 強型別。
    # 讓我們在 app/controllers/articles_controller.rb 底部新增一個名為 article_params 的私有方法，用來過濾 params。然後，讓我們變更 create 以使用它
    @article = Article.new(article_params)

    if @article.save # 如果文章儲存成功
      redirect_to @article # 動作會將瀏覽器重新導向到 文章的頁面，網址為 "http://localhost:3000/articles/#{@article.id}"
      # 在 變更 資料庫 或 應用程式 狀態 後，使用 redirect_to 非常重要。否則，如果使用者 重新整理頁面，瀏覽器會 發出相同的請求，而 變更 會 重複執行。
    else
      render :new, status: :unprocessable_entity # 否則，動作會重新顯示表單，方法是使用狀態碼 422 無法處理的實體 呈現 app/views/articles/new.html.erb。
      # redirect_to 會讓瀏覽器 發出新的請求，而 render 會為目前的請求呈現指定的檢視。
    end
  end
  # 當我們 拜訪 http://localhost:3000/articles/new 時，GET /articles/new 要求會對應到 new 動作。new 動作 不會 嘗試儲存 @article。因此，不會檢查 驗證，而且不會有 錯誤訊息。
  # 當我們 提交 表單時，POST /articles 請求會對應到 create 動作。create 動作會嘗試儲存 @article。因此，會 檢查 驗證。如果任何 驗證失敗，@article 將不會被儲存，並且 app/views/articles/new.html.erb 會以錯誤訊息呈現。

  private
    def article_params # 資料清洗後的Hash
      params.require(:article).permit(:title, :body)
    end

end
