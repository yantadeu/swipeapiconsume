# frozen_string_literal: true

class HomeController < ApplicationController
  # GET /
  def index
    load_organization
    accounts
    assets
    payments
  rescue StandardError => ex
    puts ex.message
  end

  def load_organization
    path = '/organizations'
    body_string = ''
    init_params_swipe(path: path, body_string: body_string)
    url = @base_url + '/organizations'
    request = RestClient.get(url, headers)
    object = JSON.parse(request.body)
    @organization = object['data'].nil? ? [] : object['data']
  end

  def accounts
    path = '/accounts'
    body_string = ''
    init_params_swipe(path: path, body_string: body_string)
    url = @base_url + '/accounts'
    request = RestClient.get(url, headers)
    object = JSON.parse(request.body)
    new_account if object['data'].nil?
    @accounts = object['data'].nil? ? [] : object['data']
  end

  def new_account
    path = '/accounts'
    body_string = ''
    init_params_swipe(path: path, body_string: body_string)
    url = @base_url + '/accounts'
    request = RestClient.post(url, '', headers)
    object = JSON.parse(request.body)
  end

  def new_payment
    path = '/payments'
    body_string = ''
    init_params_swipe(path: path, body_string: body_string)
    url = @base_url + '/payments'
    request = RestClient.post(url, '', headers)
    object = JSON.parse(request.body)
    puts object
  end

  def assets
    path = '/assets'
    body_string = ''
    init_params_swipe(path: path, body_string: body_string)
    url = @base_url + '/assets'
    request = RestClient.get(url, headers)
    object = JSON.parse(request.body)
    @assets = object['data'].nil? ? [] : object['data']
  end

  def payments
    path = '/payments'
    body_string = ''
    init_params_swipe(path: path, body_string: body_string)
    url = @base_url + '/payments'
    request = RestClient.get(url, headers)
    object = JSON.parse(request.body)
    new_payment if object['data'].nil?
    @payments = object['data'].nil? ? [] : object['data']
    puts @payments
  end

  private

  def init_params_swipe(path: '', body_string: '')
    secret = '140af905a8a9e073f40dbd3991f7ecc371c2513b20561b03a4adf42f75f58c62'
    string_to_sign = path + body_string
    hmac = OpenSSL::HMAC.digest('sha384', secret, string_to_sign)
    @swipe_signature = Base64.encode64(hmac)
    @swipe_signature.delete! "\n"
    @swipe_api_key = '13c59e68dfaf2838e5fc444a6187fd1d06b0f2d28b3c9195c5fc46d2d18ccbb1'
    @base_url = 'https://api.sandbox.swipetech.io'
  end

  def headers
    {
      'X-Swp-Api-Key': @swipe_api_key,
      'X-Swp-Signature': @swipe_signature
    }
  end
end
