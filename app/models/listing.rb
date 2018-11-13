class Listing < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    mount_uploaders :images, ImagesUploader

    scope :omnisearch, -> (string) { where("city ILIKE '%#{string}%' OR address ILIKE '%#{string}%'  OR title ILIKE '%#{string}%'")}

    # scope :abc, -> (column) { where("city = ?", "#{column}")}
    # scope :country, -> (column) { where("country = ?", "#{column}")}
    
    #take in params and pop in this machine
    #we are taking 
end


#for mult images, loop through them..   