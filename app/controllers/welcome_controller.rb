class WelcomeController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins'

  URL = 'localhost:8065/api/v4/users'
  PASSWORD = {'Authorization': "Bearer u5e8kono1p873ee48e7cyojaho"}

  def index
    @total = 0
    request = RestClient.get(URL, PASSWORD)
    request2 = RestClient.get("#{URL}/stats", PASSWORD)    
    @count = JSON.parse(request2)
    @users = JSON.parse(request)
    @users.each do |user|
      @total+= 1
    end
    @consumers = Consumer.all
    requestTotal = RestClient.get("localhost:8065/api/v4/analytics/old", PASSWORD)
    @dados = JSON.parse(requestTotal)

    @usuarios = News.find(1)
    @times = News.find(2)
    @canais = News.find(3)
    @mensagens = News.find(4)
  end
  
end
