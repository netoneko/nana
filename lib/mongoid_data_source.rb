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
        Nanoc::Item.new(page.content, {page: page}, page.path)
      end
    elsif klass == Nanoc::Layout
      Dir.open(dir_name).map do |filename|
        path = File.join(dir_name, filename)
        Nanoc::Layout.new(File.read(path), {}, File.basename(path)) unless File.directory? path
      end.compact
    end
  end
end
