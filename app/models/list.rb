# == Schema Information
#
# Table name: lists
#
#  id         :bigint           not null, primary key
#  inbox      :boolean          default(FALSE)
#  name       :string
#  public     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_lists_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class List < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :list_memberships
  has_many :users, through: :list_memberships

  validates :inbox, uniqueness: { scope: :owner, message: "A user can have only one inbox" }
end
