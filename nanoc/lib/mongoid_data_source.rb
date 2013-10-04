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
child1 = Page.create(content: "Child1", parent: root, slug: "child1")
child2 = Page.create(content: "Child2", parent: root, slug: "child2")
child3 = Page.create(content: "Child3", parent: child2, slug: "child3")

class MongoidDataSource < Nanoc::DataSource
  identifier :mongoid

  def items
    load_objects("/", 'item', Nanoc::Item)
  end
 
  def layouts
    load_objects(@config.fetch(:layouts_dir, 'layouts'), 'layout', Nanoc::Layout)
  end

  def load_objects(dir_name, kind, klass)
    if klass == Nanoc::Item
      Page.all.map do |page|
        path = "#{page.path.empty? ? '/index' : page.path}.erb"
        puts path
        content = Nanoc::TextualContent.new(page.content, path)
        Nanoc::Item.new(content, {}, path)
      end
    elsif klass == Nanoc::Layout
      Nanoc::FilesystemTools.all_files_in(dir_name).map do |path|
        content = Nanoc::TextualContent.new(File.read(path), File.absolute_path(path))
        Nanoc::Layout.new(content, {}, "/#{path.split('/').last}")
      end
    end
  end
end
