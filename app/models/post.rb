class Post < ApplicationRecord
  self.per_page = 10
  belongs_to :blog
  validates :name, presence: true,
                    length: { minimum: 5 }

end
