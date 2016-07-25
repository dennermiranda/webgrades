require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.

	def test_save
	user = User.new
	user.email = 'testing@tes.dot'
	user.encrypted_password = '1233333'
	user.password_salt = '123'
	user.associable_type = 'Aluno'
	user.associable_id = 2
	assert user.save
	end
end
