Rails.application.routes.draw do
  get 'channels/index'
  get 'channels/:id/posts' => 'channels#mensagens', as: :channels_mensagens
  #Rotas Teams
  get 'teams/index'
  get 'teams/:id/members' => 'teams#members', as: :teams_membros
  #--------------------------------------------
  resources :users
  resources :consumers
  #End points Class User to Mattermost
  post 'api/v1/users/login', to: 'users_mm#login', as: 'login_user', :defaults => { :format => 'json' }
  post 'api/v1/users/logout', to: 'users_mm#logout', as: 'logout_user', :defaults => { :format => 'json' }
  get 'api/v1/users', to: 'users_mm#list', as: 'listar_user', :defaults => { :format => 'json' }
  get 'api/v1/users/:id', to: 'users_mm#show', as: 'mostrar_user', :defaults => { :format => 'json' }
  post 'api/v1/users', to: 'users_mm#create', as: 'criar_user', :defaults => { :format => 'json' }
  put 'api/v1/users/:id', to: 'users_mm#update', as: 'atualizar_user', :defaults => { :format => 'json' }
  delete 'api/v1/users/:id', to: 'users_mm#deactive', as: 'desativar_user', :defaults => { :format => 'json' }
  put 'api/v1/users/:id/active', to: 'users_mm#active', as: 'ativar_user', :defaults => { :format => 'json' }
  post 'api/v1/users/usernames', to: 'users_mm#find_names', as: 'buscarnomes_user', :defaults => { :format => 'json' }
  post 'api/v1/users/ids', to: 'users_mm#find_ids', as: 'buscarids_user', :defaults => { :format => 'json' }
  put 'api/v1/users/:id/roles' => 'users_mm#roles', as: 'funcoes_user', :defaults => { :format => 'json' }
  put 'api/v1/users/:id/password' => 'users_mm#update_password', as: 'mudar_senha_user', :defaults => { :format => 'json' }
  #-------------------------------------------
  #End points Class Team to Mattermost
  post 'api/v1/teams', to: 'teams_mm#create', as: 'criar_team', :defaults => { :format => 'json' }
  get 'api/v1/teams', to: 'teams_mm#list', as: 'listar_team', :defaults => { :format => 'json' }
  get 'api/v1/teams/:id', to: 'teams_mm#show', as: 'mostrar_team', :defaults => { :format => 'json' }
  put 'api/v1/teams/:id', to: 'teams_mm#update', as: 'atualizar_team', :defaults => { :format => 'json' }
  delete 'api/v1/teams/:id', to: 'teams_mm#delete', as: 'apagar_team', :defaults => { :format => 'json' }
  put 'api/v1/teams/:id/privacy', to: 'teams_mm#privacy', as: 'privacidade_team', :defaults => { :format => 'json' }
  post 'api/v1/teams/:id/restore', to: 'teams_mm#restore', as: 'ativar_team', :defaults => { :format => 'json' }
  get 'api/v1/teams/name/:name', to: 'teams_mm#find_name', as: 'buscarnome_team', :defaults => { :format => 'json' }
  get 'api/v1/teams/:id/members', to: 'teams_mm#members', as: 'membros_team', :defaults => { :format => 'json' }
  post 'api/v1/teams/:id/members', to: 'teams_mm#add_user', as: 'adicionar_membros_team', :defaults => { :format => 'json' }
  get 'api/v1/teams/:id/stats', to: 'teams_mm#stats', as: 'total_team', :defaults => { :format => 'json' }
  #-------------------------------------------
  #End points Class Channel to Mattermost  
  get 'api/v1/channels', to: 'channels_mm#list', as: 'listar_channel', :defaults => { :format => 'json' }
  post 'api/v1/channels', to: 'channels_mm#create', as: 'criar_channel', :defaults => { :format => 'json' }
  post 'api/v1/channels/direct', to: 'channels_mm#create_direct', as: 'criar_channel_direto', :defaults => { :format => 'json' }
  post 'api/v1/channels/group', to: 'channels_mm#create_group', as: 'criar_grupo_channel', :defaults => { :format => 'json' }
  get 'api/v1/channels/:id', to: 'channels_mm#show', as: 'mostrar_channel', :defaults => { :format => 'json' }
  put 'api/v1/channels/:id', to: 'channels_mm#update', as: 'editar_channel', :defaults => { :format => 'json' }
  delete 'api/v1/channels/:id', to: 'channels_mm#delete', as: 'apagar_channel', :defaults => { :format => 'json' }
  patch 'api/v1/channels/:id/patch', to: 'channels_mm#patch', as: 'editar_parcial_channel', :defaults => { :format => 'json' }
  put 'api/v1/channels/:id/privacy', to: 'channels_mm#privacy', as: 'privacidade_channel', :defaults => { :format => 'json' }
  post 'api/v1/channels/:id/convert', to: 'channels_mm#convert', as: 'converte_channel', :defaults => { :format => 'json' }
  post 'api/v1/channels/:id/restore', to: 'channels_mm#restore', as: 'recuperar_channel', :defaults => { :format => 'json' }
  get 'api/v1/channels/:id/stats', to: 'channels_mm#stats', as: 'total_channel', :defaults => { :format => 'json' }
  get 'api/v1/teams/:id/channels', to: 'channels_mm#show_public', as: 'mostrar_publico_channel', :defaults => { :format => 'json' }
  get 'api/v1/teams/:id/channels/deleted', to: 'channels_mm#delete_channels', as: 'mostrar_deletados_channel', :defaults => { :format => 'json' }
  post 'api/v1/channels/:id/members', to: 'channels_mm#add_user', as: 'adicionar_usuario_channel', :defaults => { :format => 'json' }
  delete 'api/v1/channels/:id/members/:user_id', to: 'channels_mm#remove_user', as: 'remover_usuario_channel', :defaults => { :format => 'json' }  
  #-------------------------------------------
  #End points Class Posts to Mattermost
  post 'api/v1/posts', to: 'posts_mm#create', as: 'criar_posts', :defaults => { :format => 'json' }
  post 'api/v1/posts/ephemeral', to: 'posts_mm#create_ephemeral', as: 'criar_posts_efemera', :defaults => { :format => 'json' }
  get 'api/v1/posts/:id', to: 'posts_mm#show', as: 'mostrar_posts', :defaults => { :format => 'json' }
  delete 'api/v1/posts/:id', to: 'posts_mm#delete', as: 'deletar_posts', :defaults => { :format => 'json' }
  put 'api/v1/posts/:id', to: 'posts_mm#update', as: 'editar_posts', :defaults => { :format => 'json' }
  post 'api/v1/users/:user_id/posts/:id/set_unread', to: 'posts_mm#marcar', as: 'marcar_lida_posts', :defaults => { :format => 'json' }
  patch 'api/v1/posts/:id/patch', to: 'posts_mm#patch', as: 'editar_parcial_posts', :defaults => { :format => 'json' }
  get 'api/v1/channels/:id/posts', to: 'posts_mm#posts_channel', as: 'mostrar_posts_channels', :defaults => { :format => 'json' }  
  #-------------------------------------------
  get 'welcome/index'
  devise_for :admins
  patch 'consumers/' => 'consumers#token', as: :consumers_token
  put 'users/active/:id' => 'users#active', as: :users_ativar
  delete 'users/deactivate/:id' => 'users#deactivate', as: :users_desativar
  put 'users/:id/roles' => 'users#roles', as: :users_funcoes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
end
