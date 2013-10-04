# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers
include Nanoc::Toolbox::Helpers::Navigation

def as_menu_item(page)
  {
      title: page.title,
      link: page.link,
      subsections: []
  }
end

def root
  @root ||= Nana::Page.root
end

def root_menu
  @root_menu ||= [
      as_menu_item(root),
      root.children.map {|page| as_menu_item page}
  ].flatten
end
