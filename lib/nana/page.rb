module Nana
  class Page
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Tree

    field :content, type: String
    field :slug
    field :path

    validates_presence_of :content
    after_rearrange :rebuild_path

    private

    def rebuild_path
      self.path = self.ancestors_and_self.collect(&:slug).join('/')
    end
  end
end
