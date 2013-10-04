require "spec_helper"

describe MongoidDataSource do
  let(:path) { File.join File.dirname(__FILE__), "../../nanoc" }

  let!(:root) { Nana::Page.create(content: "Root! HAHA") }
  let!(:child1) { Nana::Page.create(content: "Child1", parent: root, slug: "child1") }
  let!(:child2) { Nana::Page.create(content: "Child2", parent: root, slug: "child2") }
  let!(:child3) { Nana::Page.create(content: "Child3", parent: child2, slug: "child3") }

  it "generates some html" do
    Dir.chdir path do
      Nanoc::CLI.run ["compile"]
    end

    Dir.new(File.join path, "output").count.should_not be_zero
  end
end
