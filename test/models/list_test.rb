# == Schema Information
#
# Table name: lists
#
#  id           :uuid             not null, primary key
#  inbox        :boolean          default(FALSE)
#  max_duration :float            default(30.0)
#  name         :string
#  public       :boolean          default(FALSE)
#  slug         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  owner_id     :uuid             not null
#
# Indexes
#
#  index_lists_on_owner_id  (owner_id)
#  index_lists_on_slug      (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
require "test_helper"

class ListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
