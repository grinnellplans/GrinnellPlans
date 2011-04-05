require 'spec_helper'

describe Plan do
  describe "#clean_text" do
    subject { Plan.new }
    def it_converts_text input, expected
      subject.edit_text = input
      subject.clean_text
      subject.plan.should == "<p class=\"sub\">#{expected}</p>"
    end

    it "is called on save" do
      subject.expects( :clean_text )
      subject.save
    end

    it "wraps paragraphs at <hr>" do
      input = "foo<hr>bar"
      expected = "<p class=\"sub\">foo</p><hr><p class=\"sub\">bar</p>"
      subject.edit_text = input
      subject.clean_text
      subject.plan.should == expected
    end

    it "sanitizes disallowed html" do
      input = "<script>alert('foo');</script> image: <img src=\"foo.jpg\" />"
      expected = "&lt;script&gt;alert('foo');&lt;/script&gt; image: &lt;img src=&quot;foo.jpg&quot; /&gt;"
      it_converts_text input, expected
    end

    it "allows safe html" do
      input = "<i>Hello</i>, shouted the <b>crazy man</b>"
      it_converts_text input, input
    end

    it "allows html but strips disallowed elements" do
      input = "<span class=\"foo\" rel=\"self\" onClick='alert(\"bar\");'>Foo bar</span>"
      expected = "<span class=\"foo\">Foo bar</span>"
      it_converts_text input, expected
    end

    it "disallows other link protocols" do
      input = "<a href='javascript:alert(\"foo\");'>Hi!</a>"
      expected = "<a>Hi!</a>"
      it_converts_text input, expected
    end

    it "parses link format" do
      pending do
        input = "here is a [http://google.com|link]!"
        expected = "here is a <a href=\"http://google.com\">link</a>!"
        it_converts_text input, expected
      end
    end

    it "parses planlove" do
      pending do
        oscar = Account.create! :username => "wildeosc", :password => "foobar", :password_confirmation => "foobar"
        input = "planlove [wildeosc]."
        expected = "planlove [<a href=\"#{Rails.application.routes.url_helpers.read_path oscar.username}\" class=\"onplan\">wildosc</a>]."
        it_converts_text input, expected
      end
    end
  end
end
