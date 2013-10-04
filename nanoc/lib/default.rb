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

def as_menu_items(pages)
  pages.map { |page| as_menu_item page }
end

def root
  @root ||= Nana::Page.root
end

def root_menu(item_page)
  @root_menu ||= [
      as_menu_item(root),
      root.children.map do |page|
        as_menu_item(page).tap do |item|
          item[:subsections] = as_menu_items(page.children) if page.children?
        end
      end
  ].flatten
end
