class UserDecorator < ApplicationDecorator
  delegate_all

  def last_contribution_number
    if contributions.present?
      "#{contributions.last.contribution_number} 草！"  
    else
      return "0"
    end
  end

  def last_mountain_name
    if mountains.present?
      "#{mountains.last.name} #{mountains.last.kana}"
    else
      return "まだ山を持っていません"
    end
  end

  def cut_count
    if contributions.present?
      "#{contributions.count} 回"
    else
      return "まだ草を刈っていません"
    end
  end
end
