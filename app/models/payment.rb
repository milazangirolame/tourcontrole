class Payment < ApplicationRecord
  belongs_to :order
  attr_accessor :number, :exp, :ccv
end
