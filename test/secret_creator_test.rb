require_relative 'test_helper'
require_relative '../lib/secret_creator'

class SecretCreatorTest < Minitest::Test
  attr_reader :sc

  def setup
    @sc = SecretCreator.new
  end

  def test_generate_secret_returns_a_string
    assert_instance_of String, sc.generate_secret
  end

  def test_it_generates_random_four_letters_each_round
    code = sc.generate_secret
    code_two = sc.generate_secret
    assert code != code_two
  end

  def test_it_has_four_letters
    code = sc.generate_secret
    assert_equal code.length, 4
  end
end
