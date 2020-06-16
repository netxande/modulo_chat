class ChannelsController < ApplicationController
  layout 'admins'
  URL = 'localhost:8065/api/v4/channels'
  PASSWORD = {'Authorization': "Bearer u5e8kono1p873ee48e7cyojaho"}

  def index
    begin
      request = RestClient.get(URL, PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      render json: error
    else
      @channels = request.body
    end
  end

  def mensagens
    id = params[:id]
    begin
      request = RestClient.get("#{URL}/#{id}/posts", PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      render json: error
    else
      ids = Array.new
      msg = JSON.parse(request)
      msg['order'].each do |user|
        ids.push(msg['posts'][user]['user_id'])
      end
      request2 = RestClient.post("localhost:8065/api/v4/users/ids", (ids).to_json, PASSWORD)
      @users = request2.body
      @msgs = request.body
    end    
  end
end
