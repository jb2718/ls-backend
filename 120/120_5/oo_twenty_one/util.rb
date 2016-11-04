# frozen_string_literal: true

module Utilities
  module Console
    def prompt(message)
      puts "=> #{message}\n"
    end
  end

  module Array
  def joinor(list, token=',', word='or')
      tail = list.last
      if list.count > 2
        head = list[0..-2]
        head.join(token) + "#{token}#{word} #{tail}"
      elsif list.count == 2
        list.first.to_s + " #{word} #{tail}"
      else
        tail.to_s
      end
    end
  end
end
