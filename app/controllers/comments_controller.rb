# rails g controller comments
# 這會建立三個檔案和一個空目錄
# create  app/controllers/comments_controller.rb --	評論控制器
# invoke  erb
# create    app/views/comments --控制器的檢視儲存在這裡
# invoke  test_unit
# create    test/controllers/comments_controller_test.rb --控制器的測試
# invoke  helper
# create    app/helpers/comments_helper.rb --檢視輔助檔案
# invoke    test_unit

class CommentsController < ApplicationController

    before_action :find_article
    
    def create
        # @article = Article.find(params[:article_id])
        # 你會看到這裡比文章的控制器複雜一些。這是你設定的 巢狀結構 的副作用。
        # 每個留言的要求都必須 追蹤 留言 所附的 文章，因此最初呼叫 Article 模型的 find 方法以取得 相關文章。
        @comment = @article.comments.create(comment_params)
        # 此外，程式碼利用了 關聯中 可用的某些方法。我們在 @article.comments 上使用 create 方法 來「建立並儲存」留言。（new + save）
        # 這會 自動連結留言，使其 屬於 特定文章。
        redirect_to article_path(@article)
        # 建立新的留言後，我們使用 article_path(@article) 輔助函式將使用者送回 原始文章。（營造及時更新留言的效果）
        # 正如我們所見，這會呼叫 ArticlesController 的 show 動作，而後者會呈現 show.html.erb 範本。
    end

    def destroy
        # @article = Article.find(params[:article_id]) # 找出要被刪掉的留言 所屬的文章
        @comment = @article.comments.find(params[:id]) # 由該文章再找到要刪掉該篇文章下 哪一則留言
        @comment.destroy # 將留言從 資料庫中 刪除
        redirect_to article_path(@article), status: :see_other
        # destroy 動作會尋找 我們正在檢視的文章，在 @article.comments 集合中 找到 留言，然後從資料庫中 移除它，並將我們 送回 文章的 顯示動作。
    end

    private
    def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
    end

    def find_article
        @article = Article.find(params[:article_id])
    end

end
