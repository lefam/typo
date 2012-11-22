#
# Inspired in the step definition provided in web_steps.rb
#
Given /^the blog is set up and running$/ do
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  User.create!({:login => 'admin',
                :password => 'admin123',
                :email => 'admin@typo.com',
                :profile_id => 1,
                :name => 'admin',
                :state => 'active'})

  User.create!({:login => 'lefam',
                :password => 'lefam123',
                :email => 'lefam@typo.com',
                :profile_id => 2,
                :name => 'lefam',
                :state => 'active'})
end

And /^I login as an admin$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'admin'
  fill_in 'user_password', :with => 'admin123'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

And /^I login as a non-admin$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'lefam'
  fill_in 'user_password', :with => 'lefam123'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

When /^I logout$/ do
  visit '/accounts/logout'
  step %Q{I should see "Successfully logged out"}
end

And /^I create an article with title "(.*)" and body "(.*)"$/ do |title, body|
  visit '/admin/content/new'
  step "show me the page"
  fill_in 'article_title', :with => title
  fill_in 'article__body_and_extended_editor', :with => body
  click_button 'Publish'
  step %Q{I should see "#{title}"}  
end

When /^I open the article with title (.*)$/ do |title|
  article = Article.find_by_title(title)
  
  article.should_not be(nil)
  visit "/admin/content/edit/#{article.id}"
end
