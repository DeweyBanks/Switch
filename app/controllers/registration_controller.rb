class RegistrationController < ApplicationController
  before_action :set_client

  def connect
    url = @client.auth_code.authorize_url(redirect_uri: @redirect_uri, scope: 'app')
    redirect_to url
  end

  def callback
    code = params[:code]
    response = @client.auth_code.get_token(code, redirect_uri: @redirect_uri, scope: 'app')
    session[:access_token] = response.token
    current_user.auth_token = response.token
    current_user.save
    redirect_to getswitch_url
  end

  def switch
    if !authenticated?
      redirect_to root_path and return
    end
    token = session[:access_token]
    url = URI.parse(@endpoints_uri)
    req = Net::HTTP::Get.new(url.request_uri)
    req['Authorization'] = 'Bearer ' + token
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")
    response = http.request(req)
    json = JSON.parse(response.body)
    uri = json[0]['uri']
    switchUrl = uri + '/switches'
    getSwitchURL = URI.parse(switchUrl)
    getSwitchReq = Net::HTTP::Get.new(getSwitchURL.request_uri)
    getSwitchReq['Authorization'] = 'Bearer ' + token
    getSwitchHttp = Net::HTTP.new(getSwitchURL.host, getSwitchURL.port)
    getSwitchHttp.use_ssl = true
    switchStatus = getSwitchHttp.request(getSwitchReq)
    @response = JSON.parse(switchStatus.body)
  end

  def authenticated?
    session[:access_token]
  end

  private

  def set_client
    options = {
      site: 'https://graph.api.smartthings.com',
      authorize_url: '/oauth/authorize',
      token_url: '/oauth/token'
    }
    @redirect_uri = 'https://dewswitch.herokuapp.com/oauth/callback'
    @endpoints_uri = 'https://graph.api.smartthings.com/api/smartapps/endpoints'
    @client = OAuth2::Client.new(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], options)
  end

end
