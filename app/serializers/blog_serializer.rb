class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :secondary_text, :body, :img_url
  has_one :user
end
