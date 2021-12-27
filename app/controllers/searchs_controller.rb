class SearchsController < ApplicationController

  def search
    # viewのform_tagにて
    #選択したmodelの値を@modelに代入
    @model = params["model"]
    #選択した検索方法の値を@methodに代入
    @method = params["method"]
    #選択ワードを@contentに代入
    @content = params["content"]
    #上記３つの＠〜を代入したsearch_forを@recordsに代入
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    #選択したモデルがuserだったら
    if model == "user"
      #選択した検索方法が完全一致だったら
      if method == "perfect"
        User.where("name LIKE?", "#{content}")
      #選択した検索方法が部分一致だったら
      elsif method == "partial"
        User.where("name LIKE?", "%#{content}%")
      #前方一致
      elsif method == "forward"
        User.where("name LIKE?", "#{content}%")
      #後方一致
      elsif method == "backward"
        User.where("name LIKE?", "%#{content}")
      else
        User.all
      end
    elsif model == "book"
      if method == "perfect"
        Book.where(["title LIKE(?) OR body LIKE(?)", "#{content}","#{content}"])
      #選択した検索方法が部分一致だったら
      elsif method == "partial"
        Book.where(["title LIKE(?) OR body LIKE(?)", "%#{content}%","%#{content}%"])
      #前方一致
      elsif method == "forward"
        Book.where(["title LIKE(?) OR body LIKE(?)", "#{content}%","#{content}%"])
      #後方一致
      elsif method == "backward"
        Book.where(["title LIKE(?) OR body LIKE(?)", "%#{content}","%#{content}"])
      else
        Book.all
      end
    end
  end

end



