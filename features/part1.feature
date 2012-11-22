Feature: merge articles
  As an administrator
  In order to summarize similar articles
  I want to have the ability to merge two articles.

Background: setting up the blog

  Given the blog is set up and running

  And I login as an admin
  And I create an article with title "Test 1" and body "This is test 1."
  And I logout

  And I login as a non-admin
  And I create an article with title "Test 2" and body "Just another test."
  And I logout

  And I am on the login page

Scenario: non-admins cannot merge articles
  When I login as a non-admin
  And I follow "All Articles"
  Then I should see "Manage articles"

Scenario: merged articles should contain the text of both previous articles
