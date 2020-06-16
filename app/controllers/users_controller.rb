class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :roles]
  layout 'admins'

  URL = 'localhost:8065/api/v4/users'
  PASSWORD = {'Authorization': "Bearer u5e8kono1p873ee48e7cyojaho"}
  #PASSWORD = {"client_id": "9pe1g1hm17b858xcka3nxydinc", "client_secret": "acxz6g38tibfuqpwzccqgu9wsa"}

  # GET /users
  # GET /users.json
  def index
    request = RestClient.get(URL, PASSWORD)
    request2 = RestClient.get("#{URL}/stats", PASSWORD)
    @count = request2.body
    @users = request.body
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.new
    @user.id = @usuario['id']
    @user.username = @usuario['username']
    @user.email = @usuario['email']
    @user.password = @usuario['password']
    @user.username = @usuario['username']
    @user.nickname = @usuario['nickname']
    @user.first_name = @usuario['first_name']
    @user.last_name = @usuario['last_name']
    @user.roles = @usuario['roles']
    @user.locale = @usuario['locale']
  end

  # POST /users
  # POST /users.json
  def create
    begin
      request = RestClient.post(URL, 
                                {'username' => params[:user][:username],
                                'email' => params[:user][:email], 
                                'password' => params[:user][:password]}.to_json,
                                PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      erro = e.response
    end
    if erro
      m = JSON.parse(erro)
      #render 'new', notice: " #{m['message']}"
      redirect_to({ action: 'new' }, notice: m['message'])
    else    
      redirect_to({ action: 'index' }, notice: "Usuário Mattermost criado com sucesso!")
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update     
    begin
      request = RestClient.put("#{URL}/#{@usuario['id']}/patch", 
                                {'username' => params[:user][:username],
                                'email' => params[:user][:email],
                                'password' => params[:user][:password],
                                'nickname' => params[:user][:nickname],
                                'first_name' => params[:user][:first_name],
                                'last_name' => params[:user][:last_name],
                                'locale' => params[:user][:locale]}.to_json,
                                PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      erro = e.response
    end
    if erro
      m = JSON.parse(erro)
      #render 'new', notice: " #{m['message']}"
      redirect_to({ action: 'edit' }, notice: m['message'])
    else    
      redirect_to({ action: 'index' }, notice: "Usuário Mattermost editado com sucesso!")
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    
  end

  def active
    id = params[:id]
    begin
      request = RestClient.put("#{URL}/#{id}/active",{"active": true}.to_json, PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      erro = e.response
    end
    if erro
      m = JSON.parse(erro)      
      redirect_to({ action: 'index' }, notice: m['message'])
    else    
      redirect_to({ action: 'index' }, notice: "Usuário ATIVADO com sucesso!")
    end 
  end

  def deactivate
    id = params[:id]
    begin
      request = RestClient.delete("#{URL}/#{id}", PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      erro = e.response
    end
    if erro
      m = JSON.parse(erro)      
      redirect_to({ action: 'index' }, notice: m['message'])
    else    
      redirect_to({ action: 'index' }, notice: "Usuário DESATIVADO com sucesso!")
    end    
  end

  def roles
    funcao = ""
    if @usuario['roles'] == "system_admin system_user"
      funcao = "system_user"
    else
      funcao = "system_admin system_user"
    end

    begin
      request = RestClient.put("#{URL}/#{@usuario['id']}/roles",{"roles": funcao}.to_json, PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      erro = e.response
    end
    if erro
      m = JSON.parse(erro)      
      redirect_to({ action: 'index' }, notice: m['message'])
    else    
      redirect_to({ action: 'index' }, notice: "Função do Usuário alterado com sucesso!")
    end 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      #@user = User.find(params[:id])
      id = params[:id]
    begin
      request = RestClient.get("#{URL}/#{id}", PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      render json: error, status: :bad_request
    else
      @usuario = JSON.parse(request) #request.body      
      #render json: users, only: ['id','username','email','roles','locale','nickname','first_name', 'last_name']
    end   
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :roles, :locale, :nickname, :first_name, :last_name, :password)
    end
end