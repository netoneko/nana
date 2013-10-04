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

Nana::Page.delete_all

root = Nana::Page.create(content: "Root! HAHA")
child1 = Nana::Page.create(content: "Child1", parent: root, slug: "child1")
child2 = Nana::Page.create(content: "Child2", parent: root, slug: "child2")
child3 = Nana::Page.create(content: "Child3", parent: child2, slug: "child3")
