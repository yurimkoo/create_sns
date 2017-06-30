class HomeController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @posts = Post.all.reverse
    @likes = Like.first
  end
  
  def write
    post = Post.create(title: params[:title], userName: params[:userName], content: params[:content], user: current_user)
    file = params[:pic]
    
    if post.invalid?
      @error_message = post.errors.messages
    else
      uploader = AvatarUploader.new
      uploader.store!(file)
      post.image_url = uploader.url
      post.save
      
      redirect_to '/'
    end
  end
  
  def update
    authorize_action_for @post
    @one_post = Post.find(params[:p_id])
  end
  
  def update_post
    one_post = Post.find(params[:p_id])
    one_post.userName = params[:userName]
    one_post.title = params[:title]
    one_post.content = params[:content]
    one_post.save
    
    redirect_to '/'
  end
  
  def destroy
    authorize_action_for @post
    one_post = Post.find(params[:p_id])
    one_post.destroy
    
    redirect_to '/'
  end
  
  def comment_create
    comment = Post.find(params[:p_id]).comments.create(userName: params[:userName], content: params[:content])
    
    if comment.invalid?
      @error_message = comment.errors.messages
    else
      comment.save
      
      redirect_to '/'
    end
  end
  
  def comment_destroy
    comment = Post.find(params[:p_id]).comments.find(params[:c_id])
    comment.destroy
    
    redirect_to '/'
  end
  
  def comment_update
    @one_comment = Post.find(params[:p_id]).comments.find(params[:c_id])
  end
  
  def comment_update_post
    one_comment = Post.find(params[:p_id]).comments.find(params[:c_id])
    one_comment.userName = params[:userName]
    one_comment.content = params[:content]
    one_comment.save
    
    redirect_to '/'
  end
  
  def like_create_post
    like = Post.find(params[:p_id]).likes.create
    like.save
    
    redirect_to '/'
  end
  
  def like_create_comment
    like = Comment.find(params[:c_id]).likes.create
    like.save
    
    redirect_to '/'
  end
  
  def email
    email = Email.create(email: "yurimzzang51@gmail.com", title: params[:title], content: params[:content])
    
    mg_client = Mailgun::Client.new("key-10c7b2f6eddecb0a954d3cece47d2963")
  
    message_params =  {
                       from: 'test@yurimsns.com',
                       to:   email.email,
                       subject: email.title,
                       text:    email.content
                       }
      
    result = mg_client.send_message("sandboxc8d4b3f8c8c144269bd535f1269e3727.mailgun.org", message_params).to_h!
      
    message_id = result['id']
    message = result['message']
    
    redirect_to '/'
  end
  
  
end
