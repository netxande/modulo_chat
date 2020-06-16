class PostsMmController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :session_user, only: [:create, :create_ephemeral, :show, :delete, :update, :patch, :marcar, :posts_channel]
  
  URL = 'localhost:8065/api/v4/posts'
  URL2 = 'localhost:8065/api/v4/channels'
  URL3 = 'localhost:8065/api/v4/users'
    
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def create
    begin 
      request = RestClient.post(URL, {'channel_id' => params[:channel_id], 'message' => params[:message], 'root_id' => params[:root_id], 'file_ids' => params[:file_ids], 'props' => params[:props]}.to_json, @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
    end
    else
      posts = JSON.parse(request)
      render json: posts, only: ['id', 'delete_at', 'edit_at', 'user_id', 'channel_id', 'root_id', 
      'parent_id', 'original_id', 'message', 'type', 'hashtag', 'filenames', 'file_ids', 'metadata'], status: :created
    end
  end

  def create_ephemeral
    begin 
      request = RestClient.post(URL, {'user_id' => params[:user_id], 'post' => params[:post]}.to_json, @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
    end
    else
      posts = JSON.parse(request)
      render json: posts, only: ['id', 'delete_at', 'edit_at', 'user_id', 'channel_id', 'root_id', 
      'parent_id', 'original_id', 'message', 'type', 'hashtag', 'filenames', 'file_ids', 'metadata'], status: :created
    end
  end

  def show
    id = params[:id]
    begin 
      request = RestClient.get("#{URL}/#{id}", @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
    end
    else
      posts = JSON.parse(request)
      render json: posts, only: ['id', 'delete_at', 'edit_at', 'user_id', 'channel_id', 'root_id', 
      'parent_id', 'original_id', 'message', 'type', 'hashtag', 'filenames', 'file_ids', 'metadata'], status: :ok
    end
  end

  def delete
    id = params[:id]
    begin 
      request = RestClient.delete("#{URL}/#{id}", @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden     
    end
    else
      posts = JSON.parse(request)
      render json: posts
    end 
  end

  def update
    id = params[:id]
    begin 
      request = RestClient.put("#{URL}/#{id}", {'id' => params[:channel_id], 'is_pinned' => params[:is_pinned], 'message' => params[:message], 'has_reactions' => params[:has_reactions], 'props' => params[:props]}.to_json, @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
    end
    else
      posts = JSON.parse(request)
      render json: posts, only: ['id', 'delete_at', 'edit_at', 'user_id', 'channel_id', 'root_id', 
      'parent_id', 'original_id', 'message', 'type', 'hashtag', 'filenames', 'file_ids', 'metadata'], status: :ok
    end
  end

  def marcar #Ainda sem solução para o erro de token expirado
    id = params[:id]
    id_user = params[:user_id]
    begin 
      request = RestClient.post("#{URL3}/#{id_user}/posts/#{id}/set_unread", @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    puts "Aqui: #{request} !!!!! #{@token_user}"
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
      when 404
        render json: error, status: :not_found
    end
    else
      posts = JSON.parse(request)
      render json: posts, only: ['team_id', 'channel_id', 'msg_count', 'mention_count', 'last_viewed_at'], status: :ok
    end
  end

  def patch
    id = params[:id]
    begin 
      request = RestClient.put("#{URL}/#{id}/patch", {'is_pinned' => params[:is_pinned], 'message' => params[:message], 'file_ids' => params[:file_ids],'has_reactions' => params[:has_reactions], 'props' => params[:props]}.to_json, @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
    end
    else
      posts = JSON.parse(request)
      render json: posts, only: ['id', 'delete_at', 'edit_at', 'user_id', 'channel_id', 'root_id', 
      'parent_id', 'original_id', 'message', 'type', 'hashtag', 'filenames', 'file_ids', 'metadata'], status: :ok
    end
  end

  def posts_channel
    id = params[:id]
    begin 
      request = RestClient.get("#{URL2}/#{id}/posts", @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
    end
    else
      posts = JSON.parse(request)
      render json: posts, only: ['order', 'posts', 'next_post_id', 'prev_post_id'], status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      #@user = User.find(params[:id])
    end

    def session_user      
      @token_user = {'Authorization': "Bearer #{request.headers["token-user"]}"}
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:post).permit(:channel_id, :message, :root_id, :file_ids, :props, :post, :is_pinned)
    end
  
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        token_pri = "secret"
        users = Consumer.all
        users.each do |user|
          #ActiveSupport::SecurityUtils.secure_compare(token, user.token)
          if (token == user.token)
            token_pri = user.token
          end
        end           
        # Compare the tokens in a time-constant manner, to mitigate
        # timing attacks.
        ActiveSupport::SecurityUtils.secure_compare(token, token_pri)
      end
  end
end
