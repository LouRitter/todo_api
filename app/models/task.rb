class Task < ApplicationRecord
  include Filterable

  validates :title, presence: true, uniqueness: true
  belongs_to :user
  scope :start_date, -> (date) { where("created_at > ?", DateTime.parse(date))}
  scope :end_date, -> (date) { where("created_at < ?", DateTime.parse(date))}
  scope :completed, -> (completed) { where(completed: completed.to_s == "true")}
  scope :title, -> (title) { where("title like ?", "#{title}%") }

end
