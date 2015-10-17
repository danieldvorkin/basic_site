require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do   	
  	get login_path																				# visit the login path
  	assert_template 'sessions/new'												# verify new session form renders properly
  	post login_path, session: {email: "", password: "" }  # post to the session controller with invalid info
  	assert_template 'sessions/new'												# verify new session form renders after failed auth
  	assert_not flash.empty?																# verify flash message is NOT empty
  	get root_path																					# visit the root path
  	assert flash.empty?																		# verify flash message IS empty 
  end
end
