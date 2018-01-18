require 'net/http'
require 'json'

class Github
  def self.favourite_language_of(user)
    new(user: user).favourite_language
  rescue RetryLimitExceededError => e
    e.message
  end

  class RetryLimitExceededError < StandardError
  end

  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def favourite_language
    languages.key(languages.values.max)
  end

  def languages
    @languages ||= data.inject{|a,b| a.merge(b){|_,x,y| x + y}}
  end

  def data
    @data ||= languages_urls.collect{|u| json_from(u)}
  end

  def languages_urls
    repositorys.collect{|r| r['languages_url']}
  end

  def repositorys
    @repositorys ||= json_from user_repos_uri
  end

  def user_repos_uri
    "https://api.github.com/users/#{user}/repos"
  end

  def json_from(uri)
    output = JSON.parse Net::HTTP.get(URI(uri))
    return output unless retry_limit_exceeded?(output)
  end

  def retry_limit_exceeded?(output)
    return false if output.kind_of?(Array)
    return false unless /rate limit exceeded/ =~ output['message']
    raise RetryLimitExceededError, 'Retry limit exceeded. Try again later'
  end

end
