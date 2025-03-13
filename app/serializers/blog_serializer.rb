class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :blog_body, :img_url, :created_at, :date
  has_one :user



  def blog_body
    object.blog_body.to_s

  end
end
