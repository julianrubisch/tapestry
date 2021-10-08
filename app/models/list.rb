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
class List < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  broadcasts

  belongs_to :owner, class_name: "User"

  has_many :list_memberships
  has_many :users, through: :list_memberships

  has_many :playable_list_items, -> { order(position: :asc) }
  has_many :playables, through: :playable_list_items

  validates :inbox, uniqueness: {scope: :owner, message: "A user can have only one inbox"}
end
