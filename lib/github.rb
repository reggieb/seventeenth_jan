require 'net/http'
require 'json'

class Github
  def self.favourite_language_of(user)
    new(user: user).favourite_language
  rescue => e
    e.message
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
    raise 'Retry limit exceeded. Try again later' unless repositorys.kind_of?(Array)
    repositorys.collect{|r| r['languages_url']}
  end

  def repositorys
    @repositorys ||= json_from user_repos_uri
  end

  def user_repos_uri
    'https://api.github.com/users/reggieb/repos'
  end

  def json_from(uri)
    JSON.parse Net::HTTP.get(URI(uri))
  end
end
