class ProjectPv < ApplicationRecord
  validates :project_id, {presence: true}
  validates :user_id, {presence: true}
  validates :user_ip, {presence: true} 
  validates :created_date, {presence: true}
end
