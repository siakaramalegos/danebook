class Photo < ActiveRecord::Base
  belongs_to :user
  has_one :cover_photo, foreign_key: :cover_photo_id, class_name: 'User', dependent: :nullify
  has_one :profile_photo, foreign_key: :profile_photo_id, class_name: 'User', dependent: :nullify

  # http://www.imagemagick.org/script/command-line-processing.php#geometry
  # timeline preserves width
  has_attached_file :photo, styles: { timeline: "600>", thumb: "100x100#", profile_thumb: "80x80#", preview: "200x200#" }, default_url: "/images/missing_:style.jpg"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
