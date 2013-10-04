require "spec_helper"
require "find"

describe MongoidDataSource do
  let(:path) { File.join File.dirname(__FILE__), "../../nanoc" }
  let(:output) { Dir.new(File.join path, "output") }

  let!(:root) { Nana::Page.create(content: "Root! HAHA") }
  let!(:child1) { Nana::Page.create(content: "Child1", parent: root, slug: "child1") }
  let!(:child2) { Nana::Page.create(content: "Child2", parent: root, slug: "child2") }
  let!(:child3) { Nana::Page.create(content: "Child3", parent: child2, slug: "child3") }

  before(:each) do
    Dir.chdir path do
      Nanoc::CLI.run ["compile"]
    end
  end

  it "generates some html" do
    output.count.should_not be_zero
  end

  it "generates the html we expect" do
    find_output.should == ["",
                           "/child1",
                           "/child1/index.html",
                           "/child2",
                           "/child2/child3",
                           "/child2/child3/index.html",
                           "/child2/index.html",
                           "/index.html"]
  end

  def find_output
    Find.find(output.path).map do |entry|
      entry.gsub output.path, ""
    end
  end
end
