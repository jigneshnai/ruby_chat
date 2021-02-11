Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root  'chatroom#index'
  get	  'login' => 'session#view_login_page'
  post	'login' => 'session#check_user_credentials'
  get	  'signup' => 'session#view_signup_page'
  post	'user_signup' => 'session#create_user'
  get	  'logout' => 'session#logout_user'

  post 'message' => 'messages#create'
	post 'message_file' => 'messages#test_file_upload'
  mount ActionCable.server, at: '.cable'
end
