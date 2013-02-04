class Band < ActiveRecord::Base

  attr_accessible :name, :tag_list
  attr_reader     :tag_list

  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :name  

  def tag_list=(form_tags)
    extract_tags(form_tags).each do |tag_name|
      tag     = Tag.find_or_create_by_name name: tag_name
      tagging = Tagging.find_or_initialize_by_tag_id_and_band_id tag.id, self.id
      self.taggings << tagging
    end
  end

private

  def extract_tags(string)
    string.split(/ |,/).reject(&:blank?)
  end

end
