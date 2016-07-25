# To change this template, choose Tools | Templates
# and open the template in the editor.

class Sala < Cefetphb

  def initialize
    has_many :diarios
    has_many :notifications
  end

end
