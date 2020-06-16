namespace :dev do

  desc "Popula as tabelas do Dashboard Notícias"
    task action: :environment do
      if Rails.env.development?
        #show_spinner("Cadastrando Classes EndPoints..."){ %x(rails dev:news) }
        show_spinner("Cadastrando os Endpoints de Usuários"){ %x(rails dev:endpoints_user) }
        show_spinner("Cadastrando os Endpoints de Times"){ %x(rails dev:endpoints_teams) }
        show_spinner("Cadastrando os Endpoints Canais"){ %x(rails dev:endpoints_channels) }
        show_spinner("Cadastrando os Endpoints de Postagens"){ %x(rails dev:endpoints_posts) }
      else 
        puts "Você não está em ambiente de desenvolvimento!"
      end
    end

  desc "Realiza inserções das Classes EndPoints"
  task news: :environment do
    News.create!(name: "Usuários", description: "Usuários Mattermost API serve!")
    News.create!(name: "Canais", description: "Canais Mattermost API serve!")
    News.create!(name: "Times", description: "Times Mattermost API serve!")
    News.create!(name: "Mensagens", description: "Mensagens Mattermost API serve!")
  end

  desc "Realiza inserções dos Endpoints: Usuários"
  task endpoints_user: :environment do
    Endpoint.create!(titulo: 'Faça login no servidor de Chat', url: 'localhost:3000/api/v1/users/login', description: 'Permite a realização de login na API com retorno de token de sessão para usuário', 
                  method: 'Method: POST', color: "blue", payload: 'Payload: {"login_id": "string","password": "string"}', response:'Response:{"id": "string","username": "string","email": "string","roles": "string","locale": "string","nickname": "string","first_name": "string","last_name": "string", "delete_at": 0}', news_id: 1)
    
    Endpoint.create!(titulo: 'Sair do servidor de Chat', url: 'localhost:3000/api/v1/users/logout', description: 'É necessária uma sessão ativa', 
                  method: 'Method: POST', color: 'blue', payload: nil , response:'Response: {"status": "string"}', news_id: 1)

    Endpoint.create!(titulo: 'Obter usuários', url: 'localhost:3000/api/v1/users', description: 'Obtenha uma página com uma lista de usuários. Com base nos parâmetros da sequência de consultas, selecione usuários de uma equipe, canal ou usuários que não estão em um canal específico.
                  Atualmente, a classificação é suportada apenas ao selecionar usuários em uma equipe.Permissões Requer uma sessão ativa e (se especificado) associação ao canal ou equipe que está sendo selecionado.', 
                  method: 'Method: GET', color: 'green', payload: nil, response:'Response: {"id": "string","username": "string","email": "string","roles": "string","locale": "string","nickname": "string","first_name": "string", "last_name": "string", "delete_at": 0}', news_id: 1)
    
    Endpoint.create!(titulo: 'Obter um usuário', url: 'localhost:3000/api/v1/users/{user_id}', description: 'Obter um objeto para um usuário. Informações sensíveis serão higienizadas.', 
                  method: 'Method: GET', color: 'green', payload: nil, response:'Response: {"id": "string","username": "string","email": "string","roles": "string","locale": "string","nickname": "string","first_name": "string", "last_name": "string", "delete_at": 0}', news_id: 1)
    
    Endpoint.create!(titulo: 'Obter usuários por IDs', url: 'localhost:3000/api/v1/users/{user_id}', description: 'Obter um objeto para um usuário. Informações sensíveis serão higienizadas.', 
                  method: 'Method: GET', color: 'green', payload: nil, response:'Response: {"id": "string","username": "string","email": "string","roles": "string","locale": "string","nickname": "string","first_name": "string", "last_name": "string", "delete_at": 0}', news_id: 1)

    Endpoint.create!(titulo: 'Crie um usuário', url: 'localhost:3000/api/v1/users', description: 'Crie um novo usuário no sistema. A senha é necessária para o login de email. Para outros tipos de autenticação, como LDAP ou SAML, são necessários os campos auth_data e auth_service.', 
                  method: 'Method: POST', color: 'blue', payload: 'Payload: {"email": "string", "username": "string", "password": "string"}', response:'Response: {"id": "string","username": "string","email": "string","roles": "string"}', news_id: 1)
    
    Endpoint.create!(titulo: 'Corrigir um usuário', url: 'localhost:3000/api/v1/users/{user_id}', description: 'Atualize parcialmente um usuário, fornecendo apenas os campos que você deseja atualizar. Os campos omitidos não serão atualizados. Os campos que podem ser atualizados são definidos no corpo da solicitação, todos os outros campos fornecidos serão ignorados.', 
                  method: 'Method: PUT', color: 'purple', payload: 'Payload: {"email": "string", "username": "string", "password": "string"}', response:'Response: {"id": "string","username": "string","email": "string","roles": "string"}', news_id: 1)

    Endpoint.create!(titulo: 'Desative uma conta de usuário.', url: 'localhost:3000/api/v1/users/{user_id}', description: 'Desativa o usuário e revoga todas as suas sessões arquivando seu objeto de usuário.', 
                  method: 'Method: DELETE', color: 'red', payload: nil, response:'Response: { "status": "string"}', news_id: 1)

    Endpoint.create!(titulo: 'Atualizar status ativo do usuário', url: 'localhost:3000/api/v1/users/{user_id}/active', description: 'Atualize o status ativo ou inativo do usuário.', 
                  method: 'Method: PUT', color: 'purple', payload: nil, response:'Response: { "status": "string"}', news_id: 1)

    Endpoint.create!(titulo: 'Obter usuários por nomes de usuário', url: 'localhost:3000/api/v1/users/usernames', description: 'Obtenha uma lista de usuários com base em uma lista fornecida de nomes de usuários.', 
                  method: 'Method: POST', color: 'blue', payload: 'Payload: ["string", "string"]', response:'Response: {["id": "string", "username": "string", "email": "string", "roles": "string"]}', news_id: 1)

    Endpoint.create!(titulo: 'Atualizar funções de um usuário', url: 'localhost:3000/api/v1/users/usernames', description: 'Obtenha uma lista de usuários com base em uma lista fornecida de nomes de usuários.', 
                  method: 'Method: POST', color: 'blue', payload: 'Payload: ["string", "string"]', response:'Response: {["id": "string", "username": "string", "email": "string", "roles": "string"]}', news_id: 1)

    Endpoint.create!(titulo: 'Atualizar a senha de um usuário', url: 'localhost:3000/api/v1/users/{user_id}/password', description: 'Atualize a senha de um usuário. A nova senha deve atender à política de senha definida pela configuração do servidor. A senha atual é necessária se você estiver atualizando sua própria senha.', 
                  method: 'Method: PUT', color: 'purple', payload: 'Payload: {"current_password": "string", "new_password": "string" }', response: 'Response: { "status": "string"}', news_id: 1)
    

  end

  desc "Realiza inserções dos Endpoints: Times"
  task endpoints_teams: :environment do
    Endpoint.create!(titulo: 'Crie uma equipe', url: 'localhost:3000/api/v1/teams', description: 'Crie uma nova equipe no sistema.', 
                  method: 'Method: POST', color: "blue", payload: 'Payload: {"name": "string","display_name": "string", "type": "string"}', response:'Response: {"id": "string", "display_name": "string", "name": "string", "description", "email": "string"}', news_id: 2)

    Endpoint.create!(titulo: 'Obter equipes', url: 'localhost:3000/api/v1/teams', description: 'Para usuários regulares, apenas retorna equipes abertas. Usuários com a permissão "manage_system" retornarão equipes, independentemente do tipo. O resultado é baseado nos parâmetros da string de consulta - página e por página.', 
                  method: 'Method: GET', color: "green", payload: nil, response:'Response: {"id": "string", "display_name": "string", "name": "string", "description", "e-mail": "string", "type": "string", "delete_at": 0}', news_id: 2)

    Endpoint.create!(titulo: 'Obter uma equipe', url: 'localhost:3000/api/v1/teams/{team_id}', description: 'Coloque uma equipe no sistema.', 
                    method: 'Method: GET', color: "green", payload: nil, response:'Response: {"id": "string", "display_name": "string", "name": "string", "description", "e-mail": "string", "type": "string", "delete_at": 0}', news_id: 2)

    Endpoint.create!(titulo: 'Atualizar uma equipe', url: 'localhost:3000/api/v1/teams/{team_id}', description: 'Atualize parcialmente uma equipe, fornecendo apenas os campos que você deseja atualizar. Os campos omitidos não serão atualizados. Os campos que podem ser atualizados são definidos no corpo da solicitação, todos os outros campos fornecidos serão ignorados.', 
                    method: 'Method: PUT', color: "purple", payload: 'Payload: { "display_name": "string", "description": "string", "company_name": "string", "invite_id": "string", "allow_open_invite": true }', response:'Response: {"id": "string", "display_name": "string", "name": "string", "description", "email": "string", "type": "string", "delete_at": 0}', news_id: 2)
                
    Endpoint.create!(titulo: 'Excluir uma equipe', url: 'localhost:3000/api/v1/teams/{team_id}', description: 'Exclui uma equipe, marcando a equipe como excluída no banco de dados. As equipes excluídas temporariamente não estarão acessíveis na interface do usuário.',
                    method: 'Method: DELETE', color: "red", payload: nil, response: 'Response: { "status": "string" }', news_id: 2)

    Endpoint.create!(titulo: 'Atualizar a privacidade das equipes', url: 'localhost:3000/api/v1/teams/{team_id}/privacy', description: 'Atualiza a privacidade da equipe, permitindo alterar uma equipe de Pública (aberta) para Privada (somente convite) e vice-versa.', 
                    method: 'Method: PUT', color: "purple", payload: 'Payload: { "privacy": "string" }', response:'Response: {"id": "string", "display_name": "string", "name": "string", "description", "e-mail": "string", "type": "string", "delete_at": 0}', news_id: 2)

    Endpoint.create!(titulo: 'Restaurar uma equipe', url: 'localhost:3000/api/v1/teams/{team_id}/restore', description: 'Restaure uma equipe que foi excluída anteriormente.', 
                    method: 'Method: POST', color: "blue", payload: nil, response:'Response: {"id": "string", "display_name": "string", "name": "string", "description", "email": "string", "type": "string", "delete_at": 0}', news_id: 2)

    Endpoint.create!(titulo: 'Obter uma equipe por nome', url: 'localhost:3000/api/v1/teams/name/{name}', description: 'Obter uma equipe com base na cadeia de nome fornecida', 
                    method: 'Method: GET', color: "green", payload: nil, response:'Response: {"id": "string", "display_name": "string", "name": "string", "description", "email": "string", "type": "string", "delete_at": 0}', news_id: 2)

    Endpoint.create!(titulo: 'Obter membros da equipe', url: 'localhost:3000/api/v1/teams/{team_id}/members', description: 'Obtenha uma lista de membros da equipe da página com base nos parâmetros da string de consulta - ID da equipe, página e por página.', 
                    method: 'Method: GET', color: "green", payload: nil, response:'Response: {"team_id": "string", "user_id": "string", "roles": "string", "delete_at": 0, "explicit_roles": "string"}', news_id: 2)

    Endpoint.create!(titulo: 'Adicionar usuário à equipe', url: 'localhost:3000/api/v1/teams/{team_id}/members', description: 'Adicione usuário à equipe pelo seu id.', 
                    method: 'Method: POST', color: "blue", payload: 'Payload: { "team_id": "string", "user_id": "string" }', response:'Response: {"team_id": "string", "user_id": "string", "roles": "string", "delete_at": 0, "explicit_roles": "string"}', news_id: 2)

    Endpoint.create!(titulo: 'Obter estatísticas da equipe', url: 'localhost:3000/api/v1/teams/{team_id}/stats', description: 'Obtenha estatísticas da equipe no sistema.', 
                    method: 'Method: GET', color: "green", payload: nil, response:'Response: { "team_id": "string", "total_member_count": 0, "active_member_count": 0 }', news_id: 2)                    
        
  end

  desc "Realiza inserções dos Endpoints: Canais"
  task endpoints_channels: :environment do
    Endpoint.create!(titulo: 'Obtenha uma lista de todos os canais', url: 'localhost:3000/api/v1/channels', description: 'Gera uma lista de canais cadastrado no sistema', 
                  method: 'Method: GET', color: "green", payload: nil, response:'Response: [ { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 } ]', news_id: 3)

    Endpoint.create!(titulo: 'Crie um canal', url: 'localhost:3000/api/v1/channels', description: 'Crie um novo canal.', 
                  method: 'Method: POST', color: "blue", payload: 'Payload: { "team_id": "string", "name": "string", "display_name": "string", "type": "string" }', response:'Response: [ { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 } ]', news_id: 3)

    Endpoint.create!(titulo: 'Crie um canal de mensagem direta', url: 'localhost:3000/api/v1/channels/direct', description: 'Crie um novo canal de mensagem direta entre dois usuários.', 
                  method: 'Method: POST', color: "blue", payload: 'Payload: [ "string", "string" ]', response:'Response: [ { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 } ]', news_id: 3)

    Endpoint.create!(titulo: 'Crie um canal de mensagens em grupo', url: 'localhost:3000/api/v1/channels/group', description: 'Crie um novo canal de mensagens em grupo para o grupo de usuários. Se o ID do usuário conectado não estiver incluído na lista, ele será anexado ao final.', 
                  method: 'Method: POST', color: "blue", payload: 'Payload: [ "string" ]', response:'Response: [ { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 } ]', news_id: 3)

    Endpoint.create!(titulo: 'Obter um canal', url: 'localhost:3000/api/v1/channels/{channel_id}', description: 'Obtenha o canal a partir da cadeia de IDs do canal fornecida.', 
                    method: 'Method: GET', color: "green", payload: nil, response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Atualizar um canal', url: 'localhost:3000/api/v1/channels/{channel_id}', description: 'Atualize um canal. Os campos que podem ser atualizados são listados como parâmetros. Os campos omitidos serão tratados como espaços em branco.', 
                      method: 'Method: PUT', color: "purple", payload: 'Payload: { "name": "string", "display_name": "string", "purpose": "string", "header": "string" }', response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Excluir um canal', url: 'localhost:3000/api/v1/channels/{channel_id}', description: 'Exclui um canal, marcando o canal como excluído no banco de dados. Os canais excluídos não serão acessíveis na interface do usuário. Os canais de mensagens diretas e de grupo não podem ser excluídos.', 
                      method: 'Method: DELETE', color: "red", payload: nil, response:'Response: { "status": "string" }', news_id: 3)

    Endpoint.create!(titulo: 'Corrigir um canal', url: 'localhost:3000/api/v1/channels/{channel_id}/patch', description: 'Atualize parcialmente um canal, fornecendo apenas os campos que você deseja atualizar. Os campos omitidos não serão atualizados. Os campos que podem ser atualizados são definidos no corpo da solicitação, todos os outros campos fornecidos serão ignorados.', 
                      method: 'Method: PUT', color: "purple", payload: 'Payload: { "name": "string", "display_name": "string", "purpose": "string", "header": "string" }', response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Atualizar a privacidade do canal', url: 'localhost:3000/api/v1/channels/{channel_id}/privacy', description: 'Atualiza a privacidade do canal, permitindo alterar um canal de Público para Privado e vice-versa.', 
                      method: 'Method: PUT', color: "purple", payload: nil, response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Converta um canal de público em privado', url: 'localhost:3000/api/v1/channels/{channel_id}/convert', description: 'Converta em canal privado a partir da cadeia de caracteres de identificação de canal fornecida.', 
                      method: 'Method: POST', color: "blue", payload: nil, response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Restaurar um canal', url: 'localhost:3000/api/v1/channels/{channel_id}/restore', description: 'Restaure o canal a partir da sequência de identificação do canal fornecida.', 
                      method: 'Method: POST', color: "blue", payload: nil, response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Obter estatísticas do canal', url: 'localhost:3000/api/v1/channels/{channel_id}/stats', description: 'Obter estatísticas para um canal.', 
                        method: 'Method: GET', color: "green", payload: nil, response:'Response: { "channel_id": "string", "member_count": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Obter canais públicos', url: 'localhost:3000/api/v1/teams/{team_id}/channels', description: 'Obtenha uma página de canais públicos em uma equipe', 
                          method: 'Method: GET', color: "green", payload: nil, response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Obter canais excluídos', url: 'localhost:3000/api/v1/teams/{team_id}/channels/deleted', description: 'Obtenha uma página de canais excluídos em uma equipe', 
                          method: 'Method: GET', color: "green", payload: nil, response:'Response: { "id": "string", "team_id": "string", "type": "string", "display_name": "string", "name": "string", "header": "string", "purpose": "string", "last_post_at": 0, "total_msg_count": 0, "extra_update_at": 0, "creator_id": "string", "delete_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Adicionar usuário ao canal', url: 'localhost:3000/api/v1/channels/{channel_id}/members', description: 'Adicione um usuário a um canal criando um objeto de membro do canal.', 
                          method: 'Method: POST', color: "blue", payload: 'Payload: { "user_id": "string", "post_root_id": "string" }', response:'Response: { "channel_id": "string", "user_id": "string", "roles": "string", "last_viewed_at": 0, "msg_count": 0, "mention_count": 0, "notify_props": [...], "last_update_at": 0 }', news_id: 3)

    Endpoint.create!(titulo: 'Remover usuário do canal', url: 'localhost:3000/api/v1/channels/{channel_id}/members/{user_id}', description: 'Exclua um membro do canal, removendo-o efetivamente de um canal.', 
                            method: 'Method: DELETE', color: "red", payload: nil, response:'Response: { "status": "string" }', news_id: 3)
        

  end

  desc "Realiza inserções dos Endpoints: Mensagens"
  task endpoints_posts: :environment do
    Endpoint.create!(titulo: 'Crie uma postagem', url: 'localhost:3000/api/v1/posts', description: 'Crie uma nova postagem em um canal. Para criar a postagem como um comentário em outra postagem', 
                  method: 'Method: POST', color: "blue", payload: 'Payload: { "channel_id": "string", "message": "string", "root_id": "string", "file_ids": [ "string" ], "props": {} }', 
                  response:'Response: { "id": "string", "create_at": 0, "update_at": 0, "delete_at": 0, "edit_at": 0, "user_id": "string", "channel_id": "string", "root_id": "string", "parent_id": "string",
              "original_id": "string", "message": "string", "type": "string", "hashtag": "string", "filenames": [ "string" ], "file_ids": [ "string" ], "metadata": []}', news_id: 4)

    Endpoint.create!(titulo: 'Criar uma postagem momentânea', url: 'localhost:3000/api/v1/posts/ephemeral', description: 'Crie uma nova postagem momentânea em um canal.', 
                  method: 'Method: POST', color: "blue", payload: 'Payload: { "user_id": "string", "post": { "channel_id": "string", "message": "string" } }', 
                  response:'Response: { "id": "string", "create_at": 0, "update_at": 0, "delete_at": 0, "edit_at": 0, "user_id": "string", "channel_id": "string", "root_id": "string", "parent_id": "string",
              "original_id": "string", "message": "string", "type": "string", "hashtag": "string", "filenames": [ "string" ], "file_ids": [ "string" ], "metadata": []}', news_id: 4)

    Endpoint.create!(titulo: 'Obter uma publicação', url: 'localhost:3000/api/v1/posts/{post_id}', description: 'Obtenha uma única postagem.', 
                  method: 'Method: GET', color: "green", payload: nil, response:'Response: { "id": "string", "create_at": 0, "update_at": 0, "delete_at": 0, "edit_at": 0, "user_id": "string", "channel_id": "string", "root_id": "string", "parent_id": "string",
              "original_id": "string", "message": "string", "type": "string", "hashtag": "string", "filenames": [ "string" ], "file_ids": [ "string" ], "metadata": []}', news_id: 4)

    Endpoint.create!(titulo: 'Excluir uma postagem', url: 'localhost:3000/api/v1/posts/{post_id}', description: 'Exclui uma postagem, marcando a postagem como excluída no banco de dados. As postagens excluídas não serão retornadas nas consultas de postagem.', 
                  method: 'Method: DELETE', color: "red", payload: nil, response:'Response: { "status": "string" }', news_id: 4)

    Endpoint.create!(titulo: 'Atualizar uma postagem', url: 'localhost:3000/api/v1/posts/{post_id}', description: 'Atualize uma postagem. Somente os campos listados abaixo são atualizáveis; os campos omitidos serão tratados em branco.', 
                  method: 'Method: PUT', color: "purple", payload: 'Payload: { "id": "string", "is_pinned": true, "message": "string", "has_reactions": true, "props": "string" }', 
                  response:'Response: { "id": "string", "create_at": 0, "update_at": 0, "delete_at": 0, "edit_at": 0, "user_id": "string", "channel_id": "string", "root_id": "string", "parent_id": "string",
              "original_id": "string", "message": "string", "type": "string", "hashtag": "string", "filenames": [ "string" ], "file_ids": [ "string" ], "metadata": []}', news_id: 4)

    Endpoint.create!(titulo: 'Marcar como não lida de uma postagem.', url: 'localhost:3000/api/v1/users/:user_id/posts/:id/set_unread', description: 'Marque um canal como não lido de uma determinada postagem.', 
                  method: 'Method: POST', color: "blue", payload: nil, response:'Response: { "team_id": "string", "channel_id": "string", "msg_count": 0, "mention_count": 0, "last_viewed_at": 0 }', news_id: 4)

  end


  private 
    def show_spinner(msg_start, msg_end = "Concluído!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})")
    end

end
