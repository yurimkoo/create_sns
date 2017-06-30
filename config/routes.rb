Rails.application.routes.draw do
  
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  get 'home/index'
  get '/errorview/error_page'
  get '/home/mypage'
  get '/users/edit'

  get 'home/index' => 'home#index'
  root 'home#index'
  
  # post
  
  get '/write' => 'home#write'
  post '/write' => 'home#write'
  
  get '/update/:p_id' => 'home#update'
  post '/update/:p_id' => 'home#update_post'
  
  get '/destroy/:p_id' => 'home#destroy'
  
  # comment
  
  post '/:p_id/comment_create' => 'home#comment_create'
  
  get '/:p_id/comment_update/:c_id' => 'home#comment_update'
  post '/:p_id/comment_update/:c_id' => 'home#comment_update_post'
  
  get '/:p_id/comment_destroy/:c_id' => 'home#comment_destroy'
  
  # like
  
  post '/:p_id/like_create' => 'home#like_create_post'
  post '/:p_id/:c_id/like_create' => 'home#like_create_comment'
  
  get '/:p_id/like_update/:l_id' => 'home#like_update'
  post '/:p_id/like_update/:l_id' => 'home#like_update_post'
  
  get '/:p_id/like_destroy/:l_id' => 'home#like_destroy'
  
  # email
  
  get '/email_write' => 'home#email_write'
  post '/email' => 'home#email'

end
