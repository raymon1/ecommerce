class Picture < ActiveRecord::Base
	belongs_to :product
	has_attached_file :image, styles: {large: "800x800>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
