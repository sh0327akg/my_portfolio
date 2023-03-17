class UserDecorator < ApplicationDecorator
  delegate_all

  def last_contribution_number
    return "0" unless contributions.present?

    "#{contributions.last.contribution_number} 草！"
  end

  def last_mountain_name
    return "まだ山を持っていません" unless mountains.present?

    "#{mountains.last.name}"
  end

  def cut_count
    return "まだ草を刈っていません" unless contributions.present?

    "#{contributions.count} 回"
  end
end
