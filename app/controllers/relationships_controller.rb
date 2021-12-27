class RelationshipsController < ApplicationController


def create
  following = current_user.follow(params[:user_id])
  following.save
  redirect_back(fallback_location: root_path)
end

def destroy
  @user = User.find(params[:followed_id])
  following = current_user.unfollow(@user)
  following.destroy
  redirect_back(fallback_location: root_path)
end

private


end
