module Listable
  extend ActiveSupport::Concern

  included do
    has_one :list_entry, as: :listable, touch: true
  end
end
