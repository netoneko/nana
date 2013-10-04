require "mongoid"
require "mongoid/tree"

Mongoid.load! File.join(File.dirname(__FILE__), "../../config/mongoid.yml"), :development

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

Page.delete_all

root = Page.create(content: "Root! HAHA")
child1 = Page.create(content: "Child1", parent: root)
child2 = Page.create(content: "Child2", parent: root)


class MongoidDataSource < Nanoc::DataSource
  identifier :mongoid

  def items
    load_objects(@config.fetch(:content_dir, ''), 'item', Nanoc::Item)
  end
 
  def layouts
    load_objects(@config.fetch(:layouts_dir, 'layouts'), 'layout', Nanoc::Layout)
  end

  def load_objects(dir_name, kind, klass)
    puts dir_name, kind, klass
    if klass == Nanoc::Item
      return Page.where(path: dir_name).map do |page|
        content = Nanoc::TextualContent.new(page.content)
        Nanoc::Item.new(content, [content, {}], page.path)
      end
    end

    []
  end
end
