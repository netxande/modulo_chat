class TeamsMmController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :session_user, only: [:create, :list, :show, :update, :delete, :privacy, :restore, :find_name, :members, :add_user, :stats]
  
  URL = 'localhost:8065/api/v4/teams'  
    
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def create
    begin 
      request = RestClient.post(URL, {'name' => params[:name], 'display_name' => params[:display_name], 'type' => params[:type]}.to_json, @token_user)
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
      team = JSON.parse(request)
      render json: team, only: ['id', 'display_name', 'name', 'description', 'email'], status: :created
    end        
  end

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
    end
    else
      team = JSON.parse(request)
      render json: team, only: ['id', 'display_name', 'name', 'description', 'email', 'type', 'delete_at'], status: :ok
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
      when 404
        render json: error, status: :not_found
    end
    else
      team = JSON.parse(request)
      render json: team, only: ['id', 'display_name', 'name', 'description', 'email', 'type', 'delete_at'], status: :ok
    end        
  end

  def update
    id = params[:id]
    begin 
      request = RestClient.put("#{URL}/#{id}/patch", {'display_name' => params[:display_name], 
                                                      'description' => params[:description], 
                                                      'company_name' => params[:company_name], 
                                                      'invite_id': params[:invite_id], 
                                                      'allow_open_invite': true}.to_json, @token_user)
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
      team = JSON.parse(request)
      render json: team, only: ['id', 'display_name', 'name', 'description', 'email', 'type', 'delete_at'], status: :ok
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
      when 404
        render json: error, status: :not_found
    end
    else
      team = JSON.parse(request)
      render json: team, status: :ok
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
      team = JSON.parse(request)
      render json: team, only: ['id', 'display_name', 'name', 'description', 'email', 'type', 'delete_at'], status: :ok
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
      team = JSON.parse(request)
      render json: team, only: ['id', 'display_name', 'name', 'description', 'email', 'type', 'delete_at'], status: :ok
    end
  end

  def find_name
    name = params[:name]
    begin 
      request = RestClient.get("#{URL}/name/#{name}", @token_user)
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
      team = JSON.parse(request)
      render json: team, only: ['id', 'display_name', 'name', 'description', 'email', 'type', 'delete_at'], status: :ok
    end
  end

  def members
    id = params[:id]
    begin 
      request = RestClient.get("#{URL}/#{id}/members", @token_user)
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
      team = JSON.parse(request)
      render json: team, only: ['team_id', 'user_id', 'roles', 'delete_at', 'explicit_roles'], status: :ok
    end
  end

  def add_user
    id = params[:id]
    begin 
      request = RestClient.post("#{URL}/#{id}/members", {'team_id' => params[:team_id], 'user_id' => params[:user_id]}.to_json, @token_user)
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
      team = JSON.parse(request)
      render json: team, only: ['team_id', 'user_id', 'roles', 'delete_at', 'explicit_roles'], status: :created
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
      when 404
        render json: error, status: :not_found
    end
    else
      team = JSON.parse(request)
      render json: team, only: ['team_id', 'total_member_count', 'active_member_count'], status: :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      #@team = Team.find(params[:id])
    end

    def session_user      
      @token_user = {'Authorization': "Bearer #{request.headers["token-user"]}"}
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :display_name, :type)
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