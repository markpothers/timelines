class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def yandm(seconds)
    m = seconds / 2628000
    yearnum = (m/12).to_i
    if yearnum == 1
      years = "year"
    else
      years = "years"
    end
    monthnum = (m - (12*yearnum)).to_i
    if monthnum == 1
      months = "month"
    else
      months = "months"
    end
  yandm = "#{yearnum} #{years} and #{monthnum} #{months}"
  end

end
