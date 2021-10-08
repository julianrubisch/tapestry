module Listable
  extend ActiveSupport::Concern

  included do
    has_one :playable, as: :listable, touch: true, dependent: :destroy
  end
end
