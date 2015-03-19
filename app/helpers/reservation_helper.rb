module ReservationHelper
  def get_reservation_slots
    (DateTime.now.beginning_of_week.to_i..DateTime.now.at_end_of_week.to_i ).step(1.hour)
                                                                           .select{|t| Time.at(t).to_datetime.hour.between?(Reservation::START_TIME,Reservation::END_TIME)}
                                                                           .map{ |t| Time.at(t).to_datetime }
                                                                           .group_by{ |t| l(t, format: :short) }
  end
end
