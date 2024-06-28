# $ rails g controller articles index --skip-routes

class ArticlesController < ApplicationController
  # Rails 應用程式不會使用 require 來載入應用程式程式碼。
  # 您可能已注意到 ArticlesController 繼承自 ApplicationController，但 app/controllers/articles_controller.rb 沒有任何require
  def index
    @articles = Article.all
  end
end
