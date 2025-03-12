class Blog < ApplicationRecord
  has_one_attached :image
  has_rich_text :description_body

  belongs_to :user

  validates :title, :description_body, presence: true

  def img_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
