# == Schema Information
#
# Table name: list_entry_list_items
#
#  id            :uuid             not null, primary key
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  list_entry_id :uuid             not null
#  list_id       :uuid             not null
#
# Indexes
#
#  index_list_entry_list_items_on_list_entry_id  (list_entry_id)
#  index_list_entry_list_items_on_list_id        (list_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_entry_id => list_entries.id)
#  fk_rails_...  (list_id => lists.id)
#
require "test_helper"

class ListEntryListItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
