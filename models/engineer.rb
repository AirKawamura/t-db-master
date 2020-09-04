class Engineer < ApplicationRecord
  include SearchCop
  
  belongs_to :company
  has_many :resumes, dependent: :destroy
  
  acts_as_ordered_taggable_on :career_roles, :skills, :locations
  
  counter_culture :company

  search_scope :search do
    attributes :price, :commercial_distribution
  end
  
  after_initialize :set_uuid
  before_save :set_age

  enum privacy: { private: 0, unlisted: 1, public: 2 }, _prefix: true
  enum gender: { unknown: 0, male: 1, female: 2 }, _prefix: true
  enum employment_type: { unknown: 0, full_timer: 1, contract_worker: 2, part_timer: 3, permatemp: 4, outsourcing_contractor: 5, etc: 99 }, _prefix: true
  enum commercial_distribution: { unknown: 0, direct: 1, under1: 2, under2: 3, under3: 4 }, _prefix: true

  def to_param
    uuid
  end

  def formatted_display_name
    display_name.blank? ? "氏名非公開" : display_name
  end

  def stub_location
    "東京23区"
  end
  
  def set_age
    if birth_at
      d1 = birth_at.strftime("%Y%m%d").to_i
      d2 = Date.current.strftime("%Y%m%d").to_i
      self.age = (d2 - d1) / 10000
    else
      self.age = nil
    end
  end

  private

    def set_uuid
      self.uuid = self.uuid.blank? ? generate_uuid : self.uuid
    end

    def generate_uuid
      token = SecureRandom.uuid
      self.class.where(uuid: token).blank? ? token : generate_uuid
    end
end
