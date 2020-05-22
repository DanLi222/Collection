module ItemConcern
  extend ActiveSupport::Concern

  included do
    scope :search, ->(filter) { where(category: filter) }
  end

  module ClassMethods
  end
end
