class ContributionDecorator < ApplicationDecorator
  delegate_all

  def display_mountain_img
    return "" unless mountain.present?
    
    case mountain.elevation
      when 3000..Float::INFINITY then 'mountain_marker_3000.svg'
      when 2500...3000 then 'mountain_marker_2500.svg'
      when 2000...2500 then 'mountain_marker_2000.svg'
      when 1000...2000 then 'mountain_marker_1000.svg'
      else 'mountain_marker.svg'
    end
  end
end
