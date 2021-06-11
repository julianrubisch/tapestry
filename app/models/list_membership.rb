# == Schema Information
#
# Table name: list_memberships
#
#  id          :uuid             not null, primary key
#  may_comment :boolean          default(FALSE)
#  may_edit    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  list_id     :uuid             not null
#  user_id     :uuid             not null
#
# Indexes
#
#  index_list_memberships_on_list_id  (list_id)
#  index_list_memberships_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#  fk_rails_...  (user_id => users.id)
#
class ListMembership < ApplicationRecord
  belongs_to :user
  belongs_to :list
end
