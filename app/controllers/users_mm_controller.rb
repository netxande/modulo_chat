class UsersMmController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :session_user, only: [:list, :show, :find_ids, :create, :update, :deactive, :active, :find_names, :roles]
  
  URL = 'localhost:8065/api/v4/users'  
    
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def login
    begin
      request = RestClient.post("#{URL}/login", {'login_id' => params[:login_id], 'password' => params[:password]}.to_json)
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
      users = JSON.parse(request)
      token = request.headers[:token]
      date = request.headers[:date]
      #render json: {token_user:token}
      response.headers["Token-user"] = token
      response.headers["Date"] = date
      render json: users, only: ['id','username','email','roles','locale','nickname','first_name', 'last_name', 'delete_at']
    end
  end

  def logout
    begin
      request = RestClient.post("#{URL}/logout", @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request      
      when 403
        render json: error, status: :forbidden
    end
    else
      users = JSON.parse(request)
      token = request.headers[:token]
      render json: {token_user:token}
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
        when 403
          render json: error, status: :forbidden
      end
    else
      users = JSON.parse(request) #request.body 
      render json: users, only: ['id','username','email','roles','locale','nickname','first_name', 'last_name', 'delete_at']
    end
  end

  # GET /users/1
  # GET /users/1.json
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
      when 404
        render json: error, status: :not_found
    end
    else
      users = JSON.parse(request) #request.body
      render json: users, only: ['id','username','email','roles','locale','nickname','first_name', 'last_name', 'delete_at']
    end
  end

  def find_ids
    begin
      request = RestClient.post("#{URL}/ids", (params[:_json]).to_json, @token_user)
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
      users = JSON.parse(request) #request.body 
      render json: users, only: ['id','username','email','roles','locale','nickname','first_name', 'last_name']
    end
  end

  # POST /users
  # POST /users.json
  def create
    begin 
      request = RestClient.post(URL, {'username' => params[:username], 'email' => params[:email], 'password' => params[:password]}.to_json, @token_user)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      case error.code
      when 400      
        render json: error, status: :bad_request     
      when 403
        render json: error, status: :forbidden
    end
    else
      user = JSON.parse(request) #request.body  
      render json: user, only: ['id', 'username', 'email', 'roles'], status: :created
    end        
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    id = params[:id]
    begin
      request = RestClient.put("#{URL}/#{id}/patch", 
                              {'username' => params[:username],
                               'email' => params[:email],                               
                               'nickname' => params[:nickname],
                               'first_name' => params[:first_name],
                               'last_name' => params[:last_name],
                               'locale' => params[:locale]}.to_json, @token_user)
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
      user = JSON.parse(request) #request.body
      render json: user, only: ['id', 'username', 'email', 'roles','nickname','firstname']
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    
  end

  def deactive
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
      user = request.body
      render json: user
    end
  end

  def active
    id = params[:id]
    begin
      request = RestClient.put("#{URL}/#{id}/active", {'active': true}.to_json, @token_user)
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
      user = request.body
      render json: user
    end
  end

  def find_names
    begin
      request = RestClient.post("#{URL}/usernames", (params[:_json]).to_json, @token_user)
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
      user = JSON.parse(request)
      render json: user, only: ['id', 'username', 'email', 'roles']
    end
  end
  
  def roles
    id = params[:id]     
    begin
      request = RestClient.put("#{URL}/#{id}/roles",{"roles"=> params[:roles]}.to_json, @token_user)
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
      message = JSON.parse(request)
      render json: message
    end
  end

  def update_password
    id = params[:id]     
    begin
      request = RestClient.put("#{URL}/#{id}/password",{"current_password"=> params[:current_password], "new_password"=> params[:new_password]}.to_json, @token_user)
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
      message = JSON.parse(request)
      render json: message
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
      params.require(:user).permit(:username, :email, :nickname, :roles, :locale, :password, :current_password, :new_password)
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