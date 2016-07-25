class Cefetphb < ActiveRecord::Base
	self.abstract_class = true
	use_connection_ninja(:database)
end
