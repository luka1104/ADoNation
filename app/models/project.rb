class Project < ApplicationRecord
    validates :user_id, {presence: true}

    has_one_attached :main_photo
    has_many_attached :photos, dependent: :destroy

    def user
        return User.find_by(id: self.user_id)
    end
end
