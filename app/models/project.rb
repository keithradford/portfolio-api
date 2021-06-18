class Project < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true, length: { minimum: 50 }
    validates :caption, presence: true
end
