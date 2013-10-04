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
    validates_uniqueness_of :path

    after_rearrange :rebuild_path

    private

    def rebuild_path
      self.path = self.root? ? "/" : self.ancestors_and_self.collect(&:slug).join("/")
    end
  end
end
