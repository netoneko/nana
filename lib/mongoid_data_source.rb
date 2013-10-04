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
      Nana::Page.all.map do |page|
        path = "#{page.path.empty? ? '/index' : page.path}.erb"
        content = Nanoc::TextualContent.new(page.content, path)
        Nanoc::Item.new(content, {}, path)
      end
    elsif klass == Nanoc::Layout
      Nanoc::FilesystemTools.all_files_in(dir_name).map do |path|
        content = Nanoc::TextualContent.new(File.read(path), File.absolute_path(path))
        Nanoc::Layout.new(content, {}, "/#{File.basename(path)}")
      end
    end
  end
end
