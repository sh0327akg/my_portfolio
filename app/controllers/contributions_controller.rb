class ContributionsController < ApplicationController
  before_action :result, only: [:index]

  Query = MyPortfolio::Client.parse <<-'GRAPHQL'
      query {
        user(login: "sh0327akg") {
          contributionsCollection {
            contributionCalendar {
              totalContributions
            }
          }
        }
      }
    GRAPHQL

  def index
    @contribution_number
  end

  private

  def result
    result = MyPortfolio::Client.query(Query)
    @contribution_number = result.data.user.contributions_collection.contribution_calendar.total_contributions
  end
end
