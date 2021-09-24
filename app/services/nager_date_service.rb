class NagerDateService
  def self.get_holiday_info
    response = Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.next_three_holidays
    holidays = get_holiday_info.map do |data|
      Holiday.new(data)
    end
    holidays[0..2]
  end
end
