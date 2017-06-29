require 'spec_helper'

describe 'The widget', type: :feature do

  it "should be included via a helper" do
    visit '/render_diet/two_renders'
    page.should have_css('div#render_diet')
  end

  it 'should show the correct number of renders' do
    visit '/render_diet/no_render'
    page.should have_css('#render_diet', :text => '0 /')
    visit '/render_diet/two_renders'
    #page.should have_css('#render_diet', :text => '2 /')
    page.should have_css('#render_diet', :text => '1 /')
  end

  it 'should reset the renders after each request' do
    visit '/render_diet/two_renders'
    visit '/render_diet/two_renders'
    #page.should have_css('#render_diet', :text => '2 /')
    page.should have_css('#render_diet', :text => '1 /')
  end

end
