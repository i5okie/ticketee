class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :assets
  has_many :comments

  accepts_nested_attributes_for :assets, reject_if: :all_blank

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

end
