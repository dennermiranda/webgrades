class Notification < ActiveRecord::Base
  belongs_to :curso
  belongs_to :sala
end
