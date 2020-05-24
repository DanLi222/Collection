module ItemConcern
  extend ActiveSupport::Concern

  # Filter result according to search
  included do
    scope :search, ->(filter) { where(category: filter) }
  end

  module ClassMethods
  end
end
