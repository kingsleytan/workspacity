class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    user.admin? or not post.published?
#     @post = Post.find(params[:id])
# authorize @post
# if @post.update(post_params)
#   redirect_to @post
# else
#   render :edit
  end
end
