require "minitest/autorun"
require_relative '../lib/github'

class GithubTest < Minitest::Test

  def user
    'paulobapmar'
  end

  def github
    @github ||= Github.new(user: user)
  end

  def test_languages_urls
    assert_match(/https:\/\/api.github.com\/repos\/#{user}\/.*\/languages/, github.languages_urls.first)
  end

  def test_favourite_language
    assert_equal 'JavaScript', github.favourite_language
  end

  def test_favourite_language_of
    assert_equal 'JavaScript', Github.favourite_language_of(user)
  end
end
