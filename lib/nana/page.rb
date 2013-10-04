module Nana
  class Page
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Tree

    field :title, type: String

    field :content, type: String
    field :slug
    field :path

    validates_presence_of :content, :title
    after_rearrange :rebuild_path

    def link
      "/#{slug}"
    end

    private

    def rebuild_path
      self.path = self.ancestors_and_self.collect(&:slug).join('/')
    end
  end
end
