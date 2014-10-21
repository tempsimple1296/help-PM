class RulesController < ApplicationController
  def rule
 
 @law=Rule.new
  end

  def comment
  end
def home
  @law=Rule.order("id DESC").all

end
def total_rule
  @law=Rule.order("id DESC").all

end
def law_insert
 lawdata=params[:ruledata][:law]
  @law=Rule.new :law=> lawdata
  if @law.save
    respond_to do |wants|
    wants.html {redirect_to '/rules/home'  }
    wants.js
  end
  end
end
def comment_insert
  
  @comment=Comment.new(comment_params)
  @comment.who_comment=session[:user_id]
 @comment.user_id=session[:user_id]
 if @comment.save
  respond_to do |wants|
    wants.html {redirect_to '/rules/home'  }
    wants.js
  end
   
 else
   redirect_to '/rules/rule'
 end
end
def like_insert
  
  rule_id=params[:likedata][:rule_id]
  like=params[:likedata][:like]
  @like_up=Like.find_by_rule_id_and_user_id(rule_id,session[:user_id])
    if @like_up
 @like_up.update_attribute :like, like
 respond_to do |wants|
    wants.html {redirect_to '/rules/home'  }
    wants.js
  end
 else
   
  @like=Like.new(like_params)
  @like.user_id=session[:user_id]
   if @like.save
   respond_to do |wants|
    wants.html {redirect_to '/rules/home'  }
    wants.js
  end
  end 
  end
end
def delete_comment
  id=params['id']
  @comment=Comment.find_by_id(id).destroy
   respond_to do |wants|
    wants.html {redirect_to '/rules/home'  }
    wants.js
  end
end
def delete_rule
  id=params['id']
  comment=Rule.find_by_id(id).destroy
  redirect_to '/rules/total_rule'
end
def like_params
     params.require(:likedata).permit(:rule_id,:like)

end

def comment_params
     params.require(:commentdata).permit(:rule_id,:comment)

end

end
