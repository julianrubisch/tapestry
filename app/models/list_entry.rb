# == Schema Information
#
# Table name: list_entries
#
#  id            :uuid             not null, primary key
#  listable_type :string
#  title         :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  list_id       :uuid             not null
#  listable_id   :uuid
#
# Indexes
#
#  index_list_entries_on_list_id  (list_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#
class ListEntry < ApplicationRecord
  belongs_to :list

  delegated_type :listable, types: %w[Track Playlist]
end
