class Listing < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    mount_uploaders :images, ImagesUploader
    scope :city, -> (column) { where("city = ?", "#{column}")}
end


#for mult images, loop through them..   