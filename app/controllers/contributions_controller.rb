class ContributionsController < ApplicationController
  Query = MyPortfolio::Client.parse <<-'GRAPHQL'
            query($user: String!) {
              user(login: $user) {
                contributionsCollection {
                  contributionCalendar {
                    totalContributions
                  }
                }
              }
            }
  GRAPHQL

  def index
    contributions = Contribution.all
    gon.mountains = contributions.map(&:mountain).uniq
  end

  def new; end

  def create
    @contribution = Contribution.new
    account_name = params[:user_name]
    api_result = graphql_result(user: account_name).user
    if api_result.present?
      # データの取り出す
      contribution_number = api_result.contributions_collection.contribution_calendar.total_contributions
      # 取得したcontribution数をセットする
      @contribution.contribution_number = contribution_number
      # 山のデータをセットする
      @contribution.mountain_id = set_mountains(contribution_number) if contribution_number >= 10
      @contribution.save!
      redirect_to contribution_path(@contribution)
    else
      flash.now[:alert] = "ユーザーが見つかりませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
    gon.mountain = @contribution.mountain
  end

  private

  def graphql_result(variables = {})
    MyPortfolio::Client.query(Query, variables:).data
  end

  def less_than_fuji(number)
    if number <= 3776
      return number 
    else
      number -= 3776
    end
  end

  def set_mountains(number)
    grass_number = less_than_fuji(number)
    mountain = Mountain.where('elevation <= ?', grass_number).min_by { |m| (m.elevation - grass_number).abs }
    mountain.id
  end
end
