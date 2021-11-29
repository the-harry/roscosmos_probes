# frozen_string_literal: true

class BaseService
  def self.call(*args)
    new.call(*args)
  end

  def self.call!(*args)
    new.call!(*args)
  end

  def call(*args)
    raise NotImplementedError
  end

  def call!(*args)
    raise NotImplementedError
  end
end
