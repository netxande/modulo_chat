class TeamsController < ApplicationController
  layout 'admins'
  URL = 'localhost:8065/api/v4/teams'
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
      @teams = request.body
    end
    #team = JSON.parse(@teams)
    #request2 = RestClient.get("#{URL}/#{team['id']}/stats", PASSWORD)
    #@total = JSON.parse(request2)
  end

  def members
    id = params[:id]
    begin
      request = RestClient.get("#{URL}/#{id}/members", PASSWORD)
      rescue RestClient::ExceptionWithResponse => e
      error = e.response
    end
    if error        
      render json: error
    else
      ids = Array.new
      teams = JSON.parse(request)
      teams.each do |user|
        ids.push(user['user_id'])
      end      
      request2 = RestClient.post("localhost:8065/api/v4/users/ids", (ids).to_json, PASSWORD)
      @users = request2.body
    end    
  end

end
