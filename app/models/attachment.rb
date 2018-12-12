class Attachment < ApplicationRecord
  belongs_to :business_asset
  mount_uploader :file, FileUploader
end
