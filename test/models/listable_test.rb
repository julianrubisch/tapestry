# == Schema Information
#
# Table name: listables
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
#  index_listables_on_list_id  (list_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#
require "test_helper"

class ListableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
