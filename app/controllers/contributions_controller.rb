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

  def index; end

  def new
    @contribution = Contribution.new
  end

  def create
    account_name = params[:user_name]
    @contribution = Contribution.new

    contribution_number = graphql_result(user: account_name).user.contributions_collection.contribution_calendar.total_contributions
    @contribution.contribution_number = contribution_number

    mountains = Mountain.where('elevation <= ?', contribution_number )
    mountain = mountains.min_by{ |m| (m.elevation - contribution_number).abs}
    @contribution.mountain_id = mountain.id
  end

  private

  def graphql_result(variables = {})
    response = MyPortfolio::Client.query(Query, variables: variables).data
  end
end
