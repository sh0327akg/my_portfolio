class ContributionsController < ApplicationController
  def index
    gon.mountains = Contribution.includes(:mountain).select(:mountain_id).distinct.map(&:mountain).compact
  end

  def new; end

  def create
    account_name = params[:user_name]
    contribution = if current_user && current_user.nickname == account_name
                     current_user.contributions.build
                   else
                     Contribution.new
                   end
    if contribution.build_for_user(account_name)
      contribution.save
      redirect_to contribution_path(contribution)
    else
      flash.now[:alert] = "ユーザーが見つかりませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
    gon.mountain = @contribution.mountain
    @next_mountain = @contribution.next_mountain if @contribution.mountain
  end
end
