class SecretCreator
  def generate_secret(size = 4)
    charset = %w{B G R Y}
    (0...size).map { charset[rand(charset.size)] }.join
  end
end
