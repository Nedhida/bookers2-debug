class RelationshipsController < ApplicationController

def create
  @user = User.find(params[:followed_id])
  current_user.follow(user)
  redireect_back(fallback_location: root_path)
end

def destroy
  @user = Relationship.find(params[:id]).followed
  current_user.unfollow(user)
  redireect_back(fallback_location: root_path)
end

end
