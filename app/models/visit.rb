class Visit < ActiveRecord::Base

  # Validations
  # ===========
  belongs_to :pin
  has_many :visit_details


  # Class Methods
  # =============
  def self.track(pin, ip_address)
    visit = Visit.find_or_create_by(pin.id)

    # check if visit is unique
    unless VisitDetail.find_by_visit_id_and_ip_address(visit.id, ip_address)
         visit.increment!(:unique_visits)
    end

    # if so increment it
    visit.increment!(:total_visits)

    # then create an instance of that visit detail
    visit_detail = visit.visit_details.create(ip_address: ip_address)
  end
end
