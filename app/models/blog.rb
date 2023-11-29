class Blog < ApplicationRecord
  has_one_attached :image
  belongs_to :user


  def img_url 
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
