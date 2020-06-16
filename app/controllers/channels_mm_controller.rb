class ChannelsMmController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :session_user, only: [:list, :create, :create_direct, :create_group, :show, :update, 
  :delete, :patch, :privacy, :convert, :restore, :stats, :show_public, :delete_channels, :add_user, :remove_user]
  
  URL = 'localhost:8065/api/v4/channels'
  URL2 = 'localhost:8065/api/v4/teams'
    
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def list
    begin 
      request = RestClient.get(URL, @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request
      when 401
        render json: error, status: :unauthorized
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end
  end

  def create
    begin 
      request = RestClient.post(URL, {'team_id' => params[:team_id], 'name' => params[:name], 'display_name' => params[:display_name], 'type' => params[:type]}.to_json, @token_user)
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
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :created
    end
  end

  def create_direct
    begin 
      request = RestClient.post("#{URL}/direct", (params[:_json]).to_json, @token_user)
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
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :created
    end
  end

  def create_group
    begin 
      request = RestClient.post("#{URL}/group", (params[:_json]).to_json, @token_user)
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
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :created
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
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end
  end

  def update
    id = params[:id]
    begin 
      request = RestClient.put("#{URL}/#{id}", {'name' => params[:name], 'display_name' => params[:display_name], 'purpose' => params[:purpose], 'header' => params[:headers]}.to_json, @token_user)
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
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
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
      channel = JSON.parse(request)
      render json: channel
    end 
  end

  def patch
    id = params[:id]
    begin 
      request = RestClient.put("#{URL}/#{id}/patch", {'name' => params[:name], 'display_name' => params[:display_name], 'purpose' => params[:purpose], 'header' => params[:headers]}.to_json, @token_user)
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
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end
  end

  def privacy
    id = params[:id]
    begin 
      request = RestClient.put("#{URL}/#{id}/privacy", @token_user)
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
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end
  end

  def convert
    id = params[:id]
    begin
      request = RestClient.post("#{URL}/#{id}/convert", @token_user)
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
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end 
  end

  def restore
    id = params[:id]
    begin 
      request = RestClient.post("#{URL}/#{id}/restore", @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code      
      when 401
        render json: error, status: :unauthorized
      when 403
        render json: error, status: :forbidden
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end
  end

  def stats
    id = params[:id]
    begin 
      request = RestClient.get("#{URL}/#{id}/stats", @token_user)
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
      channel = JSON.parse(request)
      render json: channel, only: ['channel_id', 'member_count'], status: :ok
    end
  end

  def show_public
    id = params[:id]
    begin 
      request = RestClient.get("#{URL2}/#{id}/channels", @token_user)
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
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end
  end

  def delete_channels
    id = params[:id]
    begin 
      request = RestClient.get("#{URL2}/#{id}/channels/deleted", @token_user)
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
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['id', 'team_id', 'type', 'display_name', 'name', 'header', 'purpose', 
      'last_post_at', 'total_msg_count', 'extra_update_at', 'creator_id', 'delete_at'], status: :ok
    end
  end

  def add_user
    id = params[:id]
    begin 
      request = RestClient.post("#{URL}/#{id}/members", {'user_id' => params[:user_id], 'post_root_id' => params[:post_root_id]}.to_json, @token_user)
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
      when 404
        render json: error, status: :not_found
    end
    else
      channel = JSON.parse(request)
      render json: channel, only: ['channel_id', 'user_id', 'roles', 'last_viewed_at', 'msg_count', 'mention_count', 'notify_props', 'last_update_at'], status: :created
    end
  end

  def remove_user
    id = params[:id]
    user_id = params[:user_id]
    begin 
      request = RestClient.delete("#{URL}/#{id}/members/#{user_id}", @token_user)
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
      channel = JSON.parse(request)
      render json: channel
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      #@channel = Team.find(params[:id])
    end

    def session_user      
      @token_user = {'Authorization': "Bearer #{request.headers["token-user"]}"}
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:channel).permit(:name, :display_name, :purpose, :header, :type, :team_id)
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
