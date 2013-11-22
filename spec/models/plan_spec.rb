require 'spec_helper'

describe Plan do
  before(:each) do
    @plan = FactoryGirl.create(:plan)
  end

  it 'is valid with valid attributes' do
    @plan.should be_valid
  end

  it 'is not valid when plan is longer than 16777215 characters' do
    @plan.plan =  TOO_LONG_STRING
    @plan.should_not be_valid
  end

  it 'is not valid when edit_text is longer than 16777215 characters' do
    @plan.edit_text =  TOO_LONG_STRING
    @plan.should_not be_valid
  end

  it "should protect generated_html attribute from mass assignment" do
    @plan = Plan.new(:plan=>"Candyland", :generated_html => 'hax0rz')
    @plan.generated_html.should_not == 'hax0rz'
  end

  describe "#generated_html" do
    it "is html safe" do
      subject.edit_text = "foo"
      subject.save
      subject.generated_html.should be_html_safe
    end
  end

  describe "#clean_text" do
    subject { Plan.new }
    def it_converts_text input, expected
      subject.edit_text = input
      subject.save
      subject.generated_html.should be_same_html_as "<p>#{expected}</p>"
    end

    it "is called on save" do
      subject.should_receive( :clean_text )
      subject.save
    end

    it "sanitizes disallowed html" do
      pending "I haven't finessed it quite right yet"
      input = "<script>alert('foo');</script> image: <img src=\"foo.jpg\" />"
      expected = "&lt;script&gt;alert('foo');&lt;/script&gt; image: &lt;img src=\"foo.jpg\"&gt;"
      it_converts_text input, expected
    end

    #should it escape unclosed tags, or is automatically closing them good enough?
    it "escapes unclosed tags" do
      input = "Eek <b>Bold <i>4</i> ever!"
      expected = "Eek <b>Bold <i>4</i> ever!</b>"
      it_converts_text input, expected
    end

    it "escapes unopened tags" do
      pending "functinality not implemented"
      input = " close unopened </b> tag"
      expected = "close unopened &lt;b&gt; tag"
      it_converts_text input, expected
    end

    it "wraps paragraphs at <hr>" do
      input = "foo\n<hr>bar"
      expected = "<p>foo<br></p><hr><p>bar</p>"
      subject.edit_text = input
      subject.clean_text
      pending do
        subject.generated_html.should be_same_html_as expected
      end
    end

    it "wraps paragraphs at <pre>" do
      input = "foo<pre>bar</pre>"
      expected = "<p>foo</p><pre>bar</pre>"
      subject.edit_text = input
      subject.clean_text
      subject.generated_html.should be_same_html_as expected
    end

    context 'safe html' do

      def accepts_tag(name)
        input = "<#{name}>Some text</#{name}>"
        it_converts_text input, input
      end

      def converts_tag(name, new_open, new_close)
        input = "<#{name}>Some text</#{name}>"
        expected = "<#{new_open}>Some text</#{new_close}>"
        it_converts_text input, expected
      end

      it { accepts_tag 'i' }
      it { accepts_tag 'b' }
      it { accepts_tag 'span' }
      it { accepts_tag 'code' }
      it { accepts_tag 'tt' }
      it { converts_tag 'u', "span class='underline'", 'span' }
      it { converts_tag 's', "span class='strike'", 'span' }
      it { converts_tag 'strike', "span class='strike'", 'span' }
    end

    it 'escapes non-tag brackets' do
      input = 'foo < bar << baz > foo'
      expected = 'foo &lt; bar &lt;&lt; baz &gt; foo'
      it_converts_text input, expected
    end

    it 'allows html but strips disallowed elements' do
      input = "<span class='foo' rel='self' onClick='alert(\"bar\");'>Foo bar</span>"
      expected = "<span class='foo'>Foo bar</span>"
      it_converts_text input, expected
    end

    it 'disallows other link protocols' do
      input = "<a href='javascript:alert(\"foo\");'>Hi!</a>"
      expected = '<a>Hi!</a>'
      it_converts_text input, expected
    end

    it 'supports inline code' do
      input = 'foo `bar   <script>baz</script>` foo'
      expected = 'foo <code>bar   &lt;script&gt;baz&lt;/script&gt;</code> foo'
      it_converts_text input, expected
    end

    it 'turns single newlines into <br>s' do
      input = "foo\nbar"
      expected = "foo<br>\nbar"
      it_converts_text input, expected
    end

    it 'turns double newlines into <p>s' do
      input = "foo\n\nbar"
      expected = "foo</p>\n\n<p>bar"
      it_converts_text input, expected
    end

    it "parses link format" do
        input = 'here is a [https://www.google.com/search?q=I+need+to+search&oq=I+need+to+search&aqs=chrome..69i64.10986j0j8&sourceid=chrome&espv=210&es_sm=119&ie=UTF-8|link]!'
        expected = "here is a <a href='https://www.google.com/search?q=I+need+to+search&oq=I+need+to+search&aqs=chrome..69i64.10986j0j8&sourceid=chrome&espv=210&es_sm=119&ie=UTF-8' class='onplan'>link</a>!"
        it_converts_text input, expected
    end

    it "parses planlove" do
        oscar = Account.create! :username => "wildeosc", :password => "foobar", :password_confirmation => "foobar"
        input = "planlove [wildeosc]."
        expected = "planlove [<a href='#{Rails.application.routes.url_helpers.read_plan_path oscar.username}' class='planlove'>wildeosc</a>]."
        it_converts_text input, expected
    end

    it "allows camel case planloves" do
        oscar = Account.create! :username => "wildeosc", :password => "foobar", :password_confirmation => "foobar"
        input = "planlove [WiLdeosc]."
        expected = "planlove [<a href='#{Rails.application.routes.url_helpers.read_plan_path oscar.username}' class='planlove'>WiLdeosc</a>]."
        it_converts_text input, expected
      end


    it "ignores unlinkable planloves" do
      input = "I wish [thispersohasnoplan] was on plans."
      expected = "I wish [thispersohasnoplan] was on plans."
      it_converts_text input, expected
    end
  end
end

# == Schema Information
#
# Table name: plans
#
#  id        :integer         not null, primary key
#  user_id   :integer(2)
#  plan      :text(16777215)
#  edit_text :text
#

