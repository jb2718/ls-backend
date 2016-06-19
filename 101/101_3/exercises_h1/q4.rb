require 'securerandom'
def get_uuid
  SecureRandom.uuid
end

puts get_uuid
