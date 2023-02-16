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
    @mountains = Contribution.mountains.all
  end

  def new
    @contribution = Contribution.new
  end

  def create
    account_name = params[:user_name]
    @contribution = Contribution.new

    contribution_number = graphql_result(user: account_name).user.contributions_collection.contribution_calendar.total_contributions
    @contribution.contribution_number = contribution_number
    if contribution_number <= Mountain.highest.elevation
      mountain = set_mountains(contribution_number)
    else
      # 富士山の標高をcontribution_numberから引く
      gap_contribution = contribution_number - 3776
      mountain = set_mountains(gap_contribution)
    end
    @contribution.mountain_id = mountain.id
    @contribution.save!

    redirect_to contribution_path(@contribution)
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  private

  def graphql_result(variables = {})
    MyPortfolio::Client.query(Query, variables:).data
  end

  def set_mountains(contribution_number)
    Mountain.where('elevation <= ?', contribution_number).min_by { |m| (m.elevation - contribution_number).abs }
  end
end
