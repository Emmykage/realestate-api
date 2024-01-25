class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :secondary_text, :body, :img_url, :created_at
  has_one :user
end
