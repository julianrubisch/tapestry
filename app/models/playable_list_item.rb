# == Schema Information
#
# Table name: playable_list_items
#
#  id          :uuid             not null, primary key
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  list_id     :uuid             not null
#  playable_id :uuid             not null
#
# Indexes
#
#  index_playable_list_items_on_list_id      (list_id)
#  index_playable_list_items_on_playable_id  (playable_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#  fk_rails_...  (playable_id => playables.id)
#
class PlayableListItem < ApplicationRecord
  acts_as_list scope: :list

  belongs_to :list
  belongs_to :playable
end
