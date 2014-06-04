class Pin < ActiveRecord::Base
	belongs_to :user

	acts_as_commentable



	has_attached_file :image, :styles => { :medium => "300X300>", :thumb => "100X100>" }

  

	validates :image, presence: true
	validates :description, presence: true
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

	has_one :visit

  validates :team, presence: true
  validates :position, presence: true

	def self.top_viewed(page, time_period)
    case time_period
    when "all_time"
      Pin.all_time(page)
    when "year"
      Pin.order_most_viewed(page, 1.year.ago)
    when "month"
      Pin.order_most_viewed(page, 1.month.ago)
    when "week"
      Pin.order_most_viewed(page, 1.week.ago)
    when "day"
      Pin.order_most_viewed(page, 1.day.ago)
    else
      Pin.all_time(page)
    end
  end

  def self.order_most_viewed(page, date)
    visits, ids = {}, []

    # Create a hash containing pins and their respective visit numbers
    VisitDetail.includes(:visit).where('created_at >= ?', date).each do |visit_detail|
      pin_id = visit_detail.visit.pin_id.to_s

      if visits.has_key?(pin_id)
        visits[pin_id] += 1
        else
        visits[pin_id] = 1
      end
    end

    if visits.blank?
      # Since no visits existed for this time period, we simply return an empty array
      # which will display no results on the view page
      []
      else
      # Now we sort the pins from most views to least views
      visits.sort_by{ |k,v| v }.reverse.each { |k, v| ids << k }

      # With our array of ids, we get all of the pins in the particular order
      Pin.page(page).per_page(30).where(id: ids).order_by_ids(ids)
    end
  end

  # A nice query method that will sort by ids, used for the order_most_viewed class method above
  def self.order_by_ids(ids)
    order_by = ["case"]

    ids.each_with_index.map do |id, index|
      order_by << "WHEN id='#{id}' THEN #{index}"
    end

    order_by << "end"

    order(order_by.join(" "))
  end

  def self.all_time(page)
     Pin.includes(:visit)
        .where('visits.id IS NOT NULL')
        .order("visits.total_visits DESC")
        .order("visits.total_visits > 0")
        .page(page).per_page(30)
  end


  # Instance Methods
  # ================
  def image_remote_url=(url_value)
    self.image = URI.parse(url_value) unless url_value.blank?
    super
  end

  def previous
    self.class.first(:conditions => ["id < ?", id], :order => "id desc")
  end

  def next
  self.class.first(:conditions => ["id > ?", id], :order => "id asc")
  end



end
