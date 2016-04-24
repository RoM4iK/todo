module FeaturesHelper
  def sign_in(user)
    auth_headers = user.create_new_auth_token
    # Uncomment for selenium driver
    # visit root_path
    # page.driver.browser.manage.add_cookie(:name => "auth_headers", :value => auth_headers.to_json)
    page.driver.set_cookie('auth_headers', auth_headers.to_json)
  end
end
