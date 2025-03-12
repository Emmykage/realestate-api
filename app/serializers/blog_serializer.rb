class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :secondary_text, :body, :img_url, :created_at, :description_body
  has_one :user
end
