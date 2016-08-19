class SecurityLogger
  def initialize
    @list = ""
  end

  def create_log_entry
    @list += "Data accessed at #{Time.now}\n"
  end

  def to_s
    @list
  end
end

class SecretFile

  def initialize(secret_data)
    @log = SecurityLogger.new
    @data = secret_data
  end

  def data
    @log.create_log_entry
    puts @data
  end

  def show_log
    puts @log
  end
end

secret = SecretFile.new("baboon")
secret.data
secret.show_log
sleep(1)
secret.data
secret.show_log