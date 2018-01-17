require "minitest/autorun"
require_relative '../lib/github'

class GithubTest < Minitest::Test

  def github
    @github ||= Github.new(user: 'reggieb')
  end

  def test_languages_urls
    assert_equal github.languages_urls.last, 'https://api.github.com/repos/reggieb/hypocorism/languages'
  end

  def test_data
    assert_equal github.data.last.keys, ['Ruby']
  end

  def test_favourite_language
    assert_equal github.favouite_language, 'Ruby'
  end

  def test_favourite_language_of
    assert_equal Github.favourite_language_of('reggieb'), 'Ruby'
  end
end
